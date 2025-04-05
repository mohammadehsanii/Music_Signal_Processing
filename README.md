# 🎧 Music Emotion Detection
*“Where AI meets art to understand what music feels like.”*

---

## 🧠 Project Summary

This project presents a **full-stack pipeline** for analyzing and predicting the **emotional attributes of music** based on their acoustic features. The system integrates:

- **Deep Learning** for classification  
- **MATLAB MIRtoolbox** for advanced audio feature extraction  
- **Flask Web App** for user interaction

Together, these components form a cohesive pipeline from raw audio input to emotion prediction output.

---

## ⚙️ System Architecture

```
🎵 Audio File (.mp3/.wav)
        ↓
🔬 MATLAB Feature Extraction (MIRtoolbox)
        ↓
📊 Python Preprocessing (scaler + label encoder)
        ↓
🤖 Emotion Prediction (Trained Neural Network)
        ↓
🌐 Web Interface (Upload + Result Display)
```

---

## 📂 Component Breakdown

### 🔬 1. Feature Extraction with MATLAB

**Script:** `extract_features.m`  
**Toolbox Used:** [MIRtoolbox](https://www.jyu.fi/hytk/fi/laitokset/mutku/en/research/materials/mirtoolbox)

#### Key Features Extracted:
- **Temporal:** RMS energy, tempo, attack time, zero-crossing rate  
- **Spectral:** Centroid, spread, skewness, flatness, entropy, rolloff  
- **Perceptual:** Brightness, roughness, pulse clarity  
- **MFCCs:** 13 Mel-frequency cepstral coefficients  
- **Chromagram:** 12 pitch class intensities  
- **Harmonic Change Detection Function (HCDF)** stats

> Extracted features are saved as a CSV file (`extracted_features.csv`) for downstream prediction.

#### Highlights:
- Converts stereo to mono
- Polynomial slope analysis for fluctuation, roughness, and attack time
- Descriptive error handling for robust processing

---

### 🧠 2. Deep Learning Model in Python

**Notebook:** `Music_Emotion_Detection.ipynb`  
**Frameworks Used:** TensorFlow/Keras, scikit-learn

#### Process Flow:
1. **Data Cleaning & Preprocessing:**
   - Removes duplicates
   - Drops irrelevant HCDF periodic features
   - Encodes labels with `LabelEncoder`
   - Normalizes input with `StandardScaler`

2. **EDA & Visualization:**
   - Pie chart for class distribution
   - Correlation heatmap
   - Histograms for key features

3. **Model Architecture:**
   - **3 Dense Layers**: With BatchNorm, Dropout, LeakyReLU, L2 regularization
   - **Output Layer**: Softmax for multi-class emotion classification
   - **Optimizer**: Adam with learning rate `0.001`
   - **Callbacks**: EarlyStopping to prevent overfitting

4. **Evaluation:**
   - Accuracy score
   - Training/validation curve plots
   - Confusion matrix heatmap
   - Full classification report (Precision, Recall, F1)

#### Exported Files:
- `music_emotion_model.h5` – Trained model
- `scaler.joblib` – Feature standardizer
- `LabelEncoder.joblib` – Class label encoder

---

### 🌐 3. Web Interface using Flask

**Pages:**  
- 📤 `upload.html` – Music file upload interface  
- 🎯 `result.html` – Emotion prediction display  

#### Upload Interface:
- Beautiful gradient background  
- Intuitive drag-and-drop design  
- Accepts `.mp3`, `.wav`, `.flac`, `.ogg`

#### Result Page:
- Bold emotion label display  
- Stylized confirmation card  
- CTA to “Upload Another Song”

> The backend triggers MATLAB to extract features, loads the trained model and preprocessing tools, predicts emotion, and renders results dynamically.

---

## 📊 Sample Output

- 🎵 **Input Audio**: `happy_guitar.wav`
- 📈 **Extracted Features**: 46 values
- 🤖 **Predicted Emotion**: `Joy`

---

## ✅ Strengths

- 🔄 **End-to-end Automation**: From upload to output in one click  
- 🎼 **Rich Feature Set**: Leveraging advanced MIR descriptors  
- 📉 **Robust Modeling**: Uses regularization, normalization, and early stopping  
- 💻 **User-Friendly UI**: Beautiful and functional design  

---

## ⚠️ Limitations

| Area             | Issue                                                                 |
|------------------|-----------------------------------------------------------------------|
| Feature Extraction | MATLAB dependency limits portability                               |
| Error Handling     | Flask backend can improve user feedback on exceptions              |
| Modeling           | No hyperparameter optimization or model tuning (yet)               |
| Deployment         | Not containerized; setup might be complex for new users            |

---

## 🚀 Future Improvements

1. 🔄 Replace MATLAB with `librosa` or `pyAudioAnalysis` for better portability  
2. 🔬 Hyperparameter tuning (e.g., GridSearch, Bayesian Optimization)  
3. 📦 Dockerize entire project for easy deployment  
4. 📱 Make UI responsive and mobile-friendly  
5. 🧠 Experiment with CNNs or LSTM models for sequential audio inputs

---

## 📁 Project Structure

```
📦 MusicEmotionAnalysis/
├── 📁 templates/
│   ├── upload.html
│   └── result.html
├── 🧠 Music_Emotion_Detection.ipynb
├── 📜 extract_features.m
├── 🤖 music_emotion_model.h5
├── 🧮 scaler.joblib
├── 🏷 LabelEncoder.joblib
├── 🔧 app.py (Flask App)
└── 📄 README.md
```

---

## 💬 Conclusion

This project captures the emotional fingerprint of music using a smart combination of signal processing, deep learning, and web tech. With a little refinement, it has potential not just for academia but for commercial music classification tools, therapy apps, and interactive experiences.

> _“This is not just code – it's the bridge between math and music.”_
