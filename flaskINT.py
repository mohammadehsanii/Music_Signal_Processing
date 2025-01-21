from flask import Flask, request, render_template, redirect, url_for
import os
import pandas as pd
from werkzeug.utils import secure_filename
import joblib
from tensorflow.keras.models import load_model
import matlab.engine
import numpy as np

app = Flask(__name__)

# Folder to save uploaded files
UPLOAD_FOLDER = 'music_uploaded'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Ensure upload folder exists
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# Load your model and scaler
modelApp = load_model('music_emotion_model.h5')
scalerApp = joblib.load('scaler.joblib')

# Load the LabelEncoder to convert predicted class back to original label
LabelEncoder = joblib.load('LabelEncoder.joblib')

# Start MATLAB engine
eng = matlab.engine.start_matlab()
eng.addpath(r'matlab')  # Add MATLAB script path

@app.route('/')
def upload_form():
    # Render the upload form
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload_music():
    if 'music_file' not in request.files:
        return redirect(request.url)

    file = request.files['music_file']
    
    if file.filename == '':
        return redirect(request.url)
    
    if file:
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        try:
            # Define the output CSV path for MATLAB to save extracted features
            output_csv = 'matlab/extracted_features.csv'  # Specify the CSV file, not just the directory

            # Run MATLAB script for feature extraction, passing uploaded file path and output CSV path to MATLAB
            eng.extract_features(str(filepath), str(output_csv), nargout=0)  # Ensure paths are passed as strings
            
            # Load extracted features (from MATLAB script output)
            extracted_data = pd.read_csv(output_csv)

            # Feature processing, similar to the original script
            fluctuation_cols = [col for col in extracted_data.columns if col.startswith('Fluctuation_Mean_')]
            extracted_data['Fluctuation_Mean'] = extracted_data[fluctuation_cols].mean(axis=1)
            extracted_data.drop(columns=fluctuation_cols, inplace=True)
            
            # Reorder columns if necessary (according to your existing script)
            columns = extracted_data.columns.tolist()
            columns.remove('Fluctuation_Mean')
            columns.insert(2, 'Fluctuation_Mean')
            extracted_data = extracted_data[columns]

            # Standardize features
            song_features_scaled = scalerApp.transform(extracted_data.values)

            # Perform prediction
            prediction = modelApp.predict(song_features_scaled)
            predicted_class = np.argmax(prediction, axis=1)
            emotion_class = LabelEncoder.inverse_transform(predicted_class)

            # Render result.html with the emotion prediction
            return render_template('result.html', emotion=emotion_class[0])

        except Exception as e:
            return f"An error occurred: {str(e)}"

if __name__ == '__main__':
    app.run(debug=True)
