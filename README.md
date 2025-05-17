# 📡 Signal Noise Analysis with AWGN and Rayleigh Noise in MATLAB

A MATLAB-based project to analyze how Additive White Gaussian Noise (AWGN) and Rayleigh noise affect square and sine wave signals across various frequencies and SNR levels. Includes interactive input, signal visualization, and 3D noise variance heatmaps for in-depth signal integrity assessment.

---

## 🔍 Project Overview

- Objective: Study the degradation of signals due to AWGN and Rayleigh noise  
- Signals Analyzed:  
  - Square wave  
  - Sine wave  
- Noise Types:  
  - Additive White Gaussian Noise (AWGN)  
  - Rayleigh noise  
- Input: User-defined list of frequencies and corresponding SNR values  
- Output: Time-domain plots and 3D heatmaps of noise variance vs. frequency and SNR  

## 📌 Features

- Accepts user input for multiple frequencies and SNR values  
- Generates square and sine wave signals  
- Adds AWGN using awgn()  
- Adds Rayleigh noise using raylrnd()  
- Calculates noise variance for all noisy signals  
- Visualizes:  
  - Original and noisy signals  
  - 3D surface plots (heatmaps) showing noise variance based on frequency and SNR  

## ▶️ How to Run

1. Open the MATLAB script  
2. Enter the number of frequency inputs when prompted  
3. Provide frequency (Hz) and corresponding SNR (dB) values  
4. View generated plots:  
   - Time-domain signals with AWGN and Rayleigh noise  
   - Heatmaps for variance analysis across frequency and SNR  

## 📊 Visualization

- Time-domain plots for:  
  - Original signals  
  - Signals with AWGN  
  - Signals with Rayleigh noise  
- 3D Heatmaps:  
  - Square wave with AWGN  
  - Sine wave with AWGN  
  - Square wave with Rayleigh noise  
  - Sine wave with Rayleigh noise  

## 🧰 Dependencies

- MATLAB (R2016a or later)  
- Signal Processing Toolbox (for square wave)  
- Statistics and Machine Learning Toolbox (for Rayleigh noise)  

## 👩‍💻 Author

Varshini15-official
