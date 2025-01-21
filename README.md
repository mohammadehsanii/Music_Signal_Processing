# **Music Emotion Analysis**

---

## **Overview**

This project aims to analyze and predict the emotional attributes of music tracks based on their acoustic features. It comprises three core components:

1. **Python Script (Preprocessing and Model Training)**: Handles data preprocessing, exploratory data analysis (EDA), model training, and evaluation.
2. **MATLAB Script (Feature Extraction)**: Extracts audio features using the MIRtoolbox and saves them as a `.csv` file.
3. **Flask Web Application (Deployment)**: Provides a user-friendly web interface for uploading music files and predicting their emotional attributes.

This pipeline demonstrates the synergy of advanced audio processing, machine learning, and web-based deployment.

---

## **Component Details**

---

### **1. Python Script: Preprocessing and Model Training**

This script prepares the data for machine learning, trains a neural network model, and evaluates its performance.

#### **Key Functionalities**
1. **Dataset Loading and Preprocessing**:
   - Loads a dataset of acoustic features from `Acoustic Features.csv`.
   - Handles duplicate rows and removes unnecessary columns (e.g., `_HarmonicChangeDetectionFunction_PeriodFreq`).
   - Encodes categorical target labels (emotion classes) into numerical format using `LabelEncoder`.

2. **Exploratory Data Analysis (EDA)**:
   - Identifies and visualizes categorical and numerical variables.
   - Explores class distributions using pie charts.
   - Displays correlation matrices to understand feature relationships.

3. **Feature Scaling**:
   - Uses `StandardScaler` to normalize numerical features for optimal neural network performance.

4. **Model Architecture**:
   - Constructs a neural network using TensorFlow/Keras:
     - **Input Layer**: Matches the feature dimensions.
     - **Hidden Layers**:
       - Three dense layers with:
         - Batch normalization to stabilize training.
         - Dropout for regularization and overfitting prevention.
         - Leaky ReLU activations for non-linearity.
       - L2 regularization to reduce overfitting.
     - **Output Layer**: Softmax activation for multi-class classification.
   - Early stopping is used to halt training if the validation loss does not improve for 10 epochs.

5. **Training and Evaluation**:
   - Splits the data into training and testing sets with an 80-20 split.
   - Trains the neural network and visualizes accuracy/loss trends.
   - Evaluates the model using:
     - **Accuracy**: Quantifies overall performance.
     - **Confusion Matrix**: Highlights class-wise prediction accuracy.
     - **Classification Report**: Provides precision, recall, and F1 scores.

6. **Model Export**:
   - Saves the trained model (`music_emotion_model.h5`), scaler (`scaler.joblib`), and label encoder (`LabelEncoder.joblib`) for deployment.

#### **Strengths**
- End-to-end data preprocessing and model training.
- Robust regularization techniques to improve generalization.
- Visualizations aid in understanding data and model performance.

#### **Weaknesses**
- Relies on pre-extracted features; does not integrate feature extraction.
- Could benefit from hyperparameter tuning or feature selection.

---

### **2. MATLAB Script: Feature Extraction**

This script processes raw audio files to compute a variety of acoustic features. The extracted features are saved in a `.csv` file for further analysis.

#### **Key Functionalities**
1. **Audio Preprocessing**:
   - Reads audio files in `.wav` or `.mp3` format using `audioread`.
   - Converts stereo audio to mono by averaging the two channels.

2. **Feature Computation**:
   - Extracts 46 features, grouped as:
     - **Temporal Features**: RMS energy, tempo, zero-crossing rate, attack time.
     - **Spectral Features**: Centroid, spread, skewness, flatness, kurtosis, entropy.
     - **MFCCs**: 13 Mel-Frequency Cepstral Coefficients.
     - **Other Features**: Pulse clarity, roughness, brightness, chromagram, and harmonic change detection.
   - Includes slope calculations (e.g., roughness slope, attack time slope) using polynomial fitting.

3. **Error Handling**:
   - Catches errors in feature extraction and provides descriptive messages.

4. **Output**:
   - Saves extracted features as a `.csv` file (`extracted_features.csv`).

#### **Strengths**
- Comprehensive feature set capturing temporal, spectral, and perceptual aspects of audio.
- Modular design simplifies the addition of new features.

#### **Weaknesses**
- Dependency on MATLAB and the MIRtoolbox limits portability.
- Computationally intensive for large datasets or high-throughput scenarios.

---

### **3. Flask Web Application: Deployment**

This component provides a web interface for uploading music files, processing them, and displaying emotion predictions.

#### **Key Functionalities**
1. **File Upload**:
   - Accepts music files via a secure upload form (`upload.html`).
   - Stores uploaded files in the `music_uploaded` directory.

2. **MATLAB Integration**:
   - Executes the MATLAB `extract_features` function for feature extraction.
   - Passes the uploaded file path and output `.csv` path as parameters to the MATLAB engine.

3. **Feature Processing and Prediction**:
   - Loads the extracted features from the `.csv` file.
   - Processes features (e.g., computing mean for fluctuation-related columns).
   - Standardizes features using the pre-trained scaler.
   - Uses the trained neural network model to predict the emotional class of the music file.
   - Converts the predicted numerical class back to its original label using the `LabelEncoder`.

4. **Result Display**:
   - Displays the predicted emotion class in `result.html`.

#### **Strengths**
- Intuitive and user-friendly interface for non-technical users.
- Integrates Python, MATLAB, and Flask seamlessly.

#### **Weaknesses**
- Minimal error handling for cases like invalid audio formats or missing features.
- Dependence on MATLAB complicates deployment.

---

## **System Flow**

1. **Feature Extraction (MATLAB)**:
   - Raw audio → Acoustic features (`extracted_features.csv`).
2. **Model Training (Python)**:
   - Pre-extracted features → Trained neural network.
3. **Web Application (Flask)**:
   - User uploads music → Features extracted (MATLAB) → Prediction (Python) → Results displayed.

---

## **Strengths of the Entire System**

1. **Comprehensive Pipeline**:
   - Covers the entire process from raw audio to emotion prediction.
2. **Integration**:
   - Combines MATLAB’s feature extraction capabilities with Python’s machine learning tools.
3. **User Accessibility**:
   - Provides a web-based interface for easy interaction.

---

## **Areas for Improvement**

1. **Feature Extraction**:
   - Replace MATLAB with Python (`librosa`, `pyAudioAnalysis`) to improve portability.
2. **Error Handling**:
   - Improve error handling in the Flask app and MATLAB script.
3. **Scalability**:
   - Consider containerization (e.g., Docker) to manage dependencies.
4. **Advanced Modeling**:
   - Experiment with architectures like Convolutional Neural Networks (CNNs) or Recurrent Neural Networks (RNNs) for sequential data.
5. **Frontend Enhancements**:
   - Improve `upload.html` and `result.html` design for better user experience.

---

## **Conclusion**

This project successfully integrates signal processing, machine learning, and web technologies to address an interesting problem in music emotion analysis. By addressing the limitations and optimizing deployment, it has the potential to become a robust and widely applicable tool.

---
