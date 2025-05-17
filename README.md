# Signal Noise Analysis with AWGN and Rayleigh Noise in MATLAB
This MATLAB project analyzes the effects of Additive White Gaussian Noise (AWGN) and Rayleigh noise on square wave and sine wave signals across multiple frequencies and signal-to-noise ratio (SNR) values.


## Project Description
- The program allows users to input multiple frequencies and their corresponding SNR values.
- For each frequency, it generates a square wave and a sine wave signal.
- It then adds two types of noise to these signals:
  - AWGN (Additive White Gaussian Noise)
  - Rayleigh noise
- The script computes the noise variance for each noisy signal.
- It plots the original and noisy signals for visual comparison.
- Finally, it presents heatmaps showing how noise variance changes with frequency and SNR for each noise type and signal type.

## Features
- User-defined frequencies and SNR values.
- Signal generation: square wave and sine wave.
- Noise addition:
  - AWGN using MATLAB's awgn() function.
  - Rayleigh noise generated using raylrnd().
- Noise variance calculation for quantitative analysis.
- Visualization:
  - Time-domain plots for original and noisy signals.
  - 3D surface plots (heatmaps) of noise variance versus frequency and SNR.

## Usage Instructions
1. Run the MATLAB script.
2. When prompted, enter the number of frequencies to analyze.
3. Input each frequency (in Hz) and its corresponding SNR value (in dB).
4. The script will generate plots showing:
   - Square and sine waves with and without noise.
   - Variance heatmaps depicting noise impact across frequencies and SNRs.

## Dependencies
- MATLAB (R2016a or later recommended)
- Signal Processing Toolbox (for square function)
- Statistics and Machine Learning Toolbox (for raylrnd function)

## Visualizations
- Time-domain plots:  
  Displays the original signals, signals with AWGN, and signals with Rayleigh noise side-by-side for each frequency.
- Heatmaps:  
  3D surface plots showing the relationship between frequency, SNR, and noise variance for:
  - Square wave with AWGN
  - Sine wave with AWGN
  - Square wave with Rayleigh noise
  - Sine wave with Rayleigh noise

## Author
Varshini15-official
