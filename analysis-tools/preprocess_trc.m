function d = preprocess_trc(f)
% Before presenting the signal to the network, preprocessing is performed
% to reduce the nega- tive effects of signal artifacts. Two filters were
% applied to the EEG channels: a notch filter to remove 60 Hz power line
% interference, and a band-pass filter to allow a frequency range of
% 0.5-180 Hz through. Normalization of EEG amplitude is then carried out as
% the last step to minimize the difference in EEG amplitudes using min-max
% normalization across different subjects. After the preprocessing steps,
% spectrograms are generated for each EEG channel to transform data to the
% time-frequency domain. Each 30-second epoch is transformed into log-power
% spectra via a short-time Fourier transform (STFT) with a window size of
% two seconds and a 50 % overlap, followed by logarithmic scaling. A
% Hamming window and 256-point Fast Fourier Transform (FFT) are used on
% each epoch. This results in an image S ∈ RF×T where F = 129 (the number
% of frequency bins), and T = 29 (the number of spectral columns).

d = null

end