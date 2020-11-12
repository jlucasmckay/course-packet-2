function out = plot_leg_z_spectrum(f)

if class(f)=="table"
    d = f;
else
    d = read_trc(f);
end

% delta t, seconds
delta_t = d.Time(2)-d.Time(1);

% sample rate, Hz
Fs = 1/delta_t;

marker_names = names(d);
markers = marker_names(contains(marker_names,analysis_markers()));

% bandpass filter the Z data between 0.5 and 50 Hz using the Matlab default
% filter

% z = bandpass(d{:,markers},[1 20],Fs);
z = d{:,markers};

% bandpass(d{:,markers},[1 20],Fs)
% close all
% bandpass(d{:,markers},[0.25 80],Fs)

NFFT = nrow(z);

% FFT frequencies
F = ((0:1/NFFT:1-1/NFFT)*Fs).';

% FFT values
Z = fft(z,NFFT);

magnitudeZ = abs(Z);        % Magnitude of the FFT
phaseZ = unwrap(angle(Z));  % Phase of the FFT

Fmax = 15;
plot(F(F<=Fmax),20*log10(magnitudeZ(F<=Fmax,:)));
xlabel('Frequency in kHz')
ylabel('dB')
legend(markers);

end