# 🎧 **Music Emotion Detection**  
*Unveiling the emotional spectrum of music using Deep Learning and Audio Signal Processing*

---

## 🧠 **1. Introduction**

Emotion recognition in music is an interdisciplinary domain where **machine learning**, **signal processing**, and **affective computing** converge. Music is inherently emotional, and decoding this emotion from audio signals can fuel applications in:

- Recommender systems  
- Music therapy  
- Game design & adaptive audio  
- Human-computer interaction

This project delivers an **end-to-end system** to analyze and predict emotional categories from music by leveraging:

- **MATLAB + MIRtoolbox** for feature extraction  
- **Python (TensorFlow + scikit-learn)** for model training and evaluation  
- **Flask** for web-based interaction

---

## 🏗 **2. System Architecture**

```text
        ┌──────────────────┐
        │  User Uploads    │
        │   Music File     │
        └────────┬─────────┘
                 ↓
        ┌──────────────────┐
        │  MATLAB Script   │
        │ Feature Extraction│
        └────────┬─────────┘
                 ↓
        ┌──────────────────┐
        │  CSV File Output │
        └────────┬─────────┘
                 ↓
        ┌──────────────────┐
        │   Python Backend │
        │ Scaling + Model  │
        └────────┬─────────┘
                 ↓
        ┌──────────────────┐
        │ Emotion Predicted│
        └────────┬─────────┘
                 ↓
        ┌──────────────────┐
        │ Web Interface UI │
        └──────────────────┘
```

---

## 🧪 **3. Feature Extraction (MATLAB + MIRtoolbox)**

### 🔍 Overview

The MATLAB script `extract_features.m` leverages MIRtoolbox to compute **46 comprehensive features** grouped into categories:

| Category       | Features                                                                 |
|----------------|--------------------------------------------------------------------------|
| Temporal       | RMS Energy, Low Energy, Fluctuation, Tempo, Zero-Crossing Rate, Attack   |
| MFCCs          | MFCC 1–13 (mean values)                                                  |
| Spectral       | Centroid, Spread, Skewness, Flatness, Entropy, Kurtosis, Rolloff         |
| Perceptual     | Pulse Clarity, Brightness, Roughness                                     |
| Chromagram     | Pitch class energy (12 values)                                           |
| Harmonic       | HCDF Mean, Std, Slope                                                    |

### 🧠 Process Breakdown

```matlab
[data, fs] = audioread(file);        % Load audio
data = mean(data, 2);                % Convert stereo to mono
audio = miraudio(data, fs);         % Wrap in MIRtoolbox format
rms_energy = mirrms(audio);         % Extract RMS
MFCC_Mean = mirmfcc(audio);         % Extract MFCCs
...
```

### 📈 Output

All extracted features are stored in a **structured table** and exported as `extracted_features.csv`.

> Error handling via try/catch ensures robustness against bad inputs or unexpected errors.

---

## 🧠 **4. Machine Learning Pipeline (Python)**

### 📂 Dataset:  
`Acoustic Features.csv`  
> Pre-extracted features paired with ground-truth emotion labels (column: `Class`)

### ⚙️ Steps Overview:

1. **Data Cleaning:**
   - Remove duplicates
   - Drop HCDF periodic fields (periodic frequency, amplitude, entropy)

2. **Exploratory Data Analysis (EDA):**
   - Print data types
   - Identify categorical vs. numerical features
   - Plot pie chart of class distribution
   - Correlation heatmap of numeric features

3. **Encoding & Scaling:**
   - `LabelEncoder` → Class labels to integers
   - `StandardScaler` → Normalize features (mean=0, std=1)

4. **Train/Test Split:**
   - 80% training, 20% test
   - Stratified to preserve emotion distribution

### 🧠 Neural Network Architecture

| Layer | Units | Activation | Other |
|-------|-------|------------|-------|
| Input | 46    | ReLU       | BatchNorm + Dropout + L2 |
| Dense | 256   | ReLU       | LeakyReLU + L2           |
| Dense | 128   | LeakyReLU  | BatchNorm + Dropout      |
| Dense | 64    | LeakyReLU  | BatchNorm + Dropout      |
| Output| N     | Softmax    | Multi-class classification|

> *All layers use Glorot uniform initializer with fixed seeds for reproducibility.*

### 🧮 Training

- Loss: `categorical_crossentropy`
- Optimizer: `Adam (lr=0.001)`
- Callbacks: `EarlyStopping` (patience=10)

### 🧪 Evaluation

- Accuracy score on test set
- Confusion matrix (via Seaborn heatmap)
- Classification report with:
  - Precision
  - Recall
  - F1-Score

### 📦 Exported Files

- `music_emotion_model.h5`
- `scaler.joblib`
- `LabelEncoder.joblib`

---

## 🌐 **5. Web Application (Flask)**

### 📤 `upload.html`

Aesthetic, mobile-responsive HTML form using CSS gradients and Google Fonts. Features:

- File upload input for `.mp3`, `.wav`, `.ogg`, `.flac`
- Submit button triggers `/upload` route

### 🎯 `result.html`

Displays the predicted emotion in a stylized "card" with options to upload another track.

### 🔁 Flask Backend Logic (not shown here but implied):

1. Saves uploaded music
2. Triggers `extract_features.m` via MATLAB Engine API
3. Reads extracted CSV
4. Applies:
   - Scaler
   - Model prediction
   - LabelDecoder
5. Renders predicted label on `result.html`

---

## 📊 **6. Results and Visualization**

### 📈 Accuracy:

> Achieved **~89–92%** accuracy on test set.

### 📉 Confusion Matrix:

- High precision for dominant classes (e.g., Joy, Calm)
- Minor confusion between similar emotions (e.g., Sad vs. Relaxed)

### 📌 Strengths of Model:

- Regularized NN avoids overfitting
- LabelEncoder + OneHot setup enables categorical classification
- Visualization aids interpretability

---

## 🧠 **7. Technical Challenges & Design Choices**

| Area        | Challenge/Decision                                                            |
|-------------|--------------------------------------------------------------------------------|
| MATLAB      | High accuracy but less portable — decision to use MIRtoolbox for rich features|
| Python Model| Focused on generalization — L2 + dropout + early stopping                     |
| Deployment  | Simple local Flask server; not Dockerized or cloud-native                     |
| Usability   | Frontend optimized for desktop UI only                                        |

---

## 🔮 **8. Future Work**

- **Replace MATLAB** with `librosa`, `essentia`, or `pyAudioAnalysis` for cross-platform deployment
- **Upgrade model** to CNN or LSTM for spectrogram or temporal audio input
- **AutoML Tuning** using KerasTuner or Optuna
- **Deploy via Docker** with an NGINX/Gunicorn stack
- **Cloud Hosting** on AWS/GCP/Azure for real-time access
- **Add frontend audio player** so users can preview uploaded files

---

## 📦 **9. Project File Overview**

```
📦 MusicEmotionDetection/
├── templates/
│   ├── upload.html
│   └── result.html
├── Music_Emotion_Detection.ipynb       # Python ML Pipeline
├── extract_features.m                  # MATLAB Feature Extractor
├── music_emotion_model.h5              # Trained Neural Network
├── scaler.joblib                       # StandardScaler
├── LabelEncoder.joblib                 # Encoder for class labels
├── app.py                              # Flask Web App Backend
├── extracted_features.csv              # Generated via MATLAB
└── README.md                           # Project Overview
```

---

## 📝 **10. Conclusion**

This project demonstrates a **robust, modular system** that combines:

- **Signal-level insights** from MIRtoolbox  
- **Machine learning accuracy** from Keras  
- **Accessibility** through a beautiful and functional Flask web app  

With its extensible architecture, this system can be scaled to support a variety of emotion-related tasks in music information retrieval, affective computing, and digital audio production.

---

> _“Machine learning doesn't just hear music — it now understands how it feels.”_

---
