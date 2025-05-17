clc;
clear all;
close all;

% Ask user for the number of frequencies
num_frequencies = input('Enter the number of frequencies: ');

% Initialize arrays to store the frequencies and SNR values
frequencies = zeros(1, num_frequencies);
snrs = zeros(1, num_frequencies);

% Ask user to enter each frequency and corresponding SNR value
for i = 1:num_frequencies
    frequencies(i) = input(['Enter frequency ' num2str(i) ': ']);
    snrs(i) = input(['Enter SNR value for frequency ' num2str(i) ': ']);
end

% Sampling frequency
fs = 1000;

% Time sampling with step size 0.001 (1/fs)
t = 0:1/fs:1;

% Generate square wave and sine wave signals for each frequency
square_wave_signals = zeros(num_frequencies, length(t));
sine_wave_signals = zeros(num_frequencies, length(t));

for i = 1:num_frequencies
    % Generate square wave
    square_wave_signals(i, :) = square(2 * pi * frequencies(i) * t);
    
    % Generate sine wave
    sine_wave_signals(i, :) = sin(2 * pi * frequencies(i) * t);
end

% Initialize arrays to store noisy signals
square_wave_awgn = zeros(num_frequencies, length(t));
square_wave_rayleigh = zeros(num_frequencies, length(t));
sine_wave_awgn = zeros(num_frequencies, length(t));
sine_wave_rayleigh = zeros(num_frequencies, length(t));

% Add noise to each signal
for i = 1:num_frequencies
    % Add AWGN to square wave
    square_wave_awgn(i, :) = awgn(square_wave_signals(i, :), snrs(i), 'measured');
    
    % Add AWGN to sine wave
    sine_wave_awgn(i, :) = awgn(sine_wave_signals(i, :), snrs(i), 'measured');
    
    % Generate Rayleigh noise for square wave
    rayleigh_noise_square = raylrnd(1, size(t)); % Rayleigh noise with scale parameter 1
    square_wave_rayleigh(i, :) = square_wave_signals(i, :) + rayleigh_noise_square / sqrt(2 / snrs(i));
    
    % Generate Rayleigh noise for sine wave
    rayleigh_noise_sine = raylrnd(1, size(t)); % Rayleigh noise with scale parameter 1
    sine_wave_rayleigh(i, :) = sine_wave_signals(i, :) + rayleigh_noise_sine / sqrt(2 / snrs(i));
end

% Calculate noise levels
square_wave_awgn_noise = square_wave_awgn - square_wave_signals;
square_wave_rayleigh_noise = square_wave_rayleigh - square_wave_signals;
sine_wave_awgn_noise = sine_wave_awgn - sine_wave_signals;
sine_wave_rayleigh_noise = sine_wave_rayleigh - sine_wave_signals;

% Compute the variance of the noise
square_wave_awgn_variance = var(square_wave_awgn_noise, 0, 2);
square_wave_rayleigh_variance = var(square_wave_rayleigh_noise, 0, 2);
sine_wave_awgn_variance = var(sine_wave_awgn_noise, 0, 2);
sine_wave_rayleigh_variance = var(sine_wave_rayleigh_noise, 0, 2);

% Define colors for different components
colors_signals = {'#1E90FF', '#FF4500'}; % Light Blue for signals
colors_awgn = {'#FFD700', '#8A2BE2'}; % Gold for AWGN
colors_rayleigh = {'#32CD32', '#1E90FF'}; % Lime Green for Rayleigh

% Plot square waves with AWGN and Rayleigh noise separately
figure;
for i = 1:num_frequencies
    % Plot square wave with AWGN
    subplot(num_frequencies, 4, 4*i-3);
    plot(t, square_wave_signals(i, :), 'Color', colors_signals{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Square Wave Signal, f = ' num2str(frequencies(i)) ' Hz']);
    grid on;
    
    subplot(num_frequencies, 4, 4*i-2);
    plot(t, square_wave_awgn(i, :), 'Color', colors_awgn{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Square Wave with AWGN, f = ' num2str(frequencies(i)) ' Hz, SNR = ' num2str(snrs(i)) ' dB']);
    grid on;
    
    % Plot square wave with Rayleigh noise
    subplot(num_frequencies, 4, 4*i-1);
    plot(t, square_wave_signals(i, :), 'Color', colors_signals{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Square Wave Signal, f = ' num2str(frequencies(i)) ' Hz']);
    grid on;
    
    subplot(num_frequencies, 4, 4*i);
    plot(t, square_wave_rayleigh(i, :), 'Color', colors_rayleigh{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Square Wave with Rayleigh Noise, f = ' num2str(frequencies(i)) ' Hz, SNR = ' num2str(snrs(i)) ' dB']);
    grid on;
end

% Plot sine waves with AWGN and Rayleigh noise separately
figure;
for i = 1:num_frequencies
    % Plot sine wave with AWGN
    subplot(num_frequencies, 4, 4*i-3);
    plot(t, sine_wave_signals(i, :), 'Color', colors_signals{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Sine Wave Signal, f = ' num2str(frequencies(i)) ' Hz']);
    grid on;
    
    subplot(num_frequencies, 4, 4*i-2);
    plot(t, sine_wave_awgn(i, :), 'Color', colors_awgn{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Sine Wave with AWGN, f = ' num2str(frequencies(i)) ' Hz, SNR = ' num2str(snrs(i)) ' dB']);
    grid on;
    
    % Plot sine wave with Rayleigh noise
    subplot(num_frequencies, 4, 4*i-1);
    plot(t, sine_wave_signals(i, :), 'Color', colors_signals{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Sine Wave Signal, f = ' num2str(frequencies(i)) ' Hz']);
    grid on;
    
    subplot(num_frequencies, 4, 4*i);
    plot(t, sine_wave_rayleigh(i, :), 'Color', colors_rayleigh{1}, 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('Amplitude');
    title(['Sine Wave with Rayleigh Noise, f = ' num2str(frequencies(i)) ' Hz, SNR = ' num2str(snrs(i)) ' dB']);
    grid on;
end

% Prepare data for the heatmaps
[snrGrid, freqGrid] = meshgrid(snrs, frequencies);

% For each noise type, calculate variance across frequencies and SNR values
% Initialize matrices to store the heatmap data
Z_square_awgn = NaN(length(frequencies), length(snrs));
Z_sine_awgn = NaN(length(frequencies), length(snrs));
Z_square_rayleigh = NaN(length(frequencies), length(snrs));
Z_sine_rayleigh = NaN(length(frequencies), length(snrs));

% Fill the heatmap matrices
for i = 1:num_frequencies
    freq_idx = find(frequencies == frequencies(i));
    snr_idx = find(snrs == snrs(i));
    
    Z_square_awgn(freq_idx, snr_idx) = square_wave_awgn_variance(i);
    Z_sine_awgn(freq_idx, snr_idx) = sine_wave_awgn_variance(i);
    Z_square_rayleigh(freq_idx, snr_idx) = square_wave_rayleigh_variance(i);
    Z_sine_rayleigh(freq_idx, snr_idx) = sine_wave_rayleigh_variance(i);
end

% Plot frequencies vs. SNR values with noise variance as heatmaps
figure;
subplot(2, 2, 1);
surf(snrGrid, freqGrid, Z_square_awgn', 'EdgeColor', 'none');
xlabel('SNR (dB)');
ylabel('Frequency (Hz)');
zlabel('Variance of Noise');
title('Square Wave with AWGN');
colorbar;
% Add labels for NaN values
[rows, cols] = find(isnan(Z_square_awgn));
for k = 1:length(rows)
    text(snrs(cols(k)), frequencies(rows(k)), 0, 'NaN', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'r');
end

subplot(2, 2, 2);
surf(snrGrid, freqGrid, Z_sine_awgn', 'EdgeColor', 'none');
xlabel('SNR (dB)');
ylabel('Frequency (Hz)');
zlabel('Variance of Noise');
title('Sine Wave with AWGN');
colorbar;
% Add labels for NaN values
[rows, cols] = find(isnan(Z_sine_awgn));
for k = 1:length(rows)
    text(snrs(cols(k)), frequencies(rows(k)), 0, 'NaN', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'r');
end

subplot(2, 2, 3);
surf(snrGrid, freqGrid, Z_square_rayleigh', 'EdgeColor', 'none');
xlabel('SNR (dB)');
ylabel('Frequency (Hz)');
zlabel('Variance of Noise');
title('Square Wave with Rayleigh Noise');
colorbar;
% Add labels for NaN values
[rows, cols] = find(isnan(Z_square_rayleigh));
for k = 1:length(rows)
    text(snrs(cols(k)), frequencies(rows(k)), 0, 'NaN', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'r');
end

subplot(2, 2, 4);
surf(snrGrid, freqGrid, Z_sine_rayleigh', 'EdgeColor', 'none');
xlabel('SNR (dB)');
ylabel('Frequency (Hz)');
zlabel('Variance of Noise');
title('Sine Wave with Rayleigh Noise');
colorbar;
% Add labels for NaN values
[rows, cols] = find(isnan(Z_sine_rayleigh));
for k = 1:length(rows)
    text(snrs(cols(k)), frequencies(rows(k)), 0, 'NaN', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'r');
end