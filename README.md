# **Music Emotion Analysis**


# 🎵 Music Emotion Analysis 🎧  
*Unlocking the emotional soul of sound using AI & Signal Processing*

---

## 🌟 Overview

This project bridges the gap between **audio signal processing**, **machine learning**, and **web technology** to **predict the emotional attributes of music tracks**. It is built as an end-to-end pipeline that seamlessly integrates:

- 🧠 **Python (Model Training & Evaluation)**
- 🔬 **MATLAB (Feature Extraction via MIRtoolbox)**
- 🌐 **Flask (Web Deployment)**

Whether you're a researcher, developer, or music enthusiast, this tool offers a scalable and modular framework for **emotion recognition in music**.

---

## 🧩 System Architecture

```
🎵 Audio Input (.mp3/.wav)
       ⬇
🔬 Feature Extraction (MATLAB)
       ⬇
📊 Preprocessing & Prediction (Python)
       ⬇
🌐 Web Interface (Flask)
       ⬇
🎭 Emotion Output
```

---

## 🛠️ Components

### 1️⃣ Python: Preprocessing & Model Training

Handles data preparation, EDA, model architecture, and evaluation.

**Highlights:**
- Cleans and normalizes features (`StandardScaler`)
- Visualizes class distributions and correlations
- Neural Network with:
  - 3 Dense layers + LeakyReLU + Dropout + BatchNorm
  - L2 Regularization + EarlyStopping
- Model Export: `music_emotion_model.h5`, `scaler.joblib`, `LabelEncoder.joblib`

📈 **Evaluation Metrics:**
- Accuracy
- Confusion Matrix
- Classification Report (Precision, Recall, F1-score)

---

### 2️⃣ MATLAB: Audio Feature Extraction

Uses **MIRtoolbox** to extract 46 diverse features capturing temporal, spectral, and perceptual information.

**Feature Types:**
- Temporal: RMS energy, zero-crossing rate, tempo
- Spectral: Centroid, spread, skewness, flatness, entropy
- MFCCs (1–13)
- Perceptual: Brightness, roughness, harmonic change detection
- Chromagram (1–12)

**Export:** Results saved to `extracted_features.csv`

📌 *Script:* [`extract_features.m`](extract_features.m)  
⚠️ *Requires MATLAB with MIRtoolbox*

---

### 3️⃣ Flask App: Emotion Prediction via Web

Provides a clean web interface for users to upload songs and receive emotion predictions in real-time.

**Core Features:**
- Upload `.wav` / `.mp3` files
- Triggers MATLAB extraction backend
- Applies Python ML model for prediction
- Displays predicted **emotion label**

📂 Upload Page: `upload.html`  
📄 Results Page: `result.html`

---

## 🔄 Workflow Summary

1. 🎧 **User uploads a song**
2. 🛠️ **MATLAB extracts acoustic features**
3. 🤖 **Python model predicts emotion**
4. 📺 **Web app displays results**

---

## ✅ Strengths

- ✅ Full-stack audio ML pipeline
- ✅ Clear separation of concerns (Feature extraction, modeling, deployment)
- ✅ Rich feature set from MIRtoolbox
- ✅ Exportable and reusable trained model

---

## ⚠️ Limitations

- MATLAB dependency (limits portability)
- Minimal exception handling in Flask
- Feature extraction not yet implemented in Python

---

## 🚀 Future Improvements

| Feature Area        | Suggestions                                  |
|---------------------|----------------------------------------------|
| 🎧 Feature Extraction | Switch to `librosa` or `pyAudioAnalysis`     |
| 🧠 Modeling           | Try CNNs, RNNs, or attention-based models    |
| 🌐 Deployment         | Containerize with Docker                     |
| ⚠️ Error Handling     | Add checks for invalid inputs, extraction errors |
| 💅 Frontend          | Redesign UI for a modern look                |

---

## 📦 Files in Repository

- `Music_Emotion_Detection.ipynb` – Python training & inference
- `extract_features.m` – MATLAB feature extractor
- `music_emotion_model.h5` – Trained model weights
- `scaler.joblib` / `LabelEncoder.joblib` – Saved preprocessing tools
- `README.md` – This file 🫡

---

## 📣 Conclusion

This project is a solid blueprint for music-based emotion classification using hybrid technologies. With some optimizations and polishing, it can serve as a robust research tool, an engaging app, or a launching pad for music AI applications.

> _"Where words fail, music speaks — now, with machine learning, we understand what it says."_ 🎶

---

