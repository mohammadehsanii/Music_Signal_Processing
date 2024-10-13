% Load audio file using audioread (works for .wav and .mp3 files)
file = 'C:/Users/ez/0/just-relax-11157.mp3'; % Replace with your file path
[data, fs] = audioread(file); % 'data' is the audio signal, 'fs' is the sampling rate

% If the audio has two channels (stereo), convert it to mono
if size(data, 2) > 1
    data = mean(data, 2); % Average the two channels to create a mono signal
end

% Use the audio signal with MIRtoolbox
audio = miraudio(data, fs); % This converts the audio data into a format MIRtoolbox can process

% 1. RMS Energy Mean
rms_energy = mirrms(audio);
RMSenergy_Mean = mean(mirgetdata(rms_energy));

% 2. Low Energy Mean
low_energy = mirlowenergy(audio);
Lowenergy_Mean = mean(mirgetdata(low_energy));

% 3. Fluctuation Mean
fluctuation = mirfluctuation(audio);
Fluctuation_Mean = mean(mirgetdata(fluctuation));

% 4. Tempo Mean
tempo = mirtempo(audio);
Tempo_Mean = mean(mirgetdata(tempo));

% 5-17. MFCC Mean (1-13)
mfcc = mirmfcc(audio);
mfcc_data = mirgetdata(mfcc);
for i = 1:13
    eval(['MFCC_Mean_', num2str(i), ' = mean(mfcc_data(', num2str(i), ',:));']);
end

% 18. Roughness Mean
roughness = mirroughness(audio);
Roughness_Mean = mean(mirgetdata(roughness));

% Manual computation of Roughness Slope using polyfit
roughness_data = mirgetdata(roughness);
time_roughness = (1:length(roughness_data))'; % Time values for the slope calculation
p_roughness = polyfit(time_roughness, roughness_data, 1); % 1st-degree polynomial fit
Roughness_Slope = p_roughness(1); % The slope is the first coefficient

% 20. Zero-crossing rate Mean
zcr = mirzerocross(audio);
Zero_crossingrate_Mean = mean(mirgetdata(zcr));

% 21. Attack Time Mean
attack_time = mirattacktime(audio);
AttackTime_Mean = mean(mirgetdata(attack_time));

% Manual computation of Attack Time Slope using polyfit
attack_time_data = mirgetdata(attack_time);
time_attack = (1:length(attack_time_data))';
p_attack = polyfit(time_attack, attack_time_data, 1);
AttackTime_Slope = p_attack(1);

% 23. Rolloff Mean
rolloff = mirrolloff(audio);
Rolloff_Mean = mean(mirgetdata(rolloff));

% 24. Event Density Mean
event_density = mireventdensity(audio);
Eventdensity_Mean = mean(mirgetdata(event_density));

% 25. Pulse Clarity Mean
pulse_clarity = mirpulseclarity(audio);
Pulseclarity_Mean = mean(mirgetdata(pulse_clarity));

% 26. Brightness Mean
brightness = mirbrightness(audio);
Brightness_Mean = mean(mirgetdata(brightness));

% 27. Spectral Centroid Mean
spectral_centroid = mircentroid(audio);
Spectralcentroid_Mean = mean(mirgetdata(spectral_centroid));

% 28. Spectral Spread Mean
spectral_spread = mirspread(audio);
Spectralspread_Mean = mean(mirgetdata(spectral_spread));

% 29. Spectral Skewness Mean
spectral_skewness = mirskewness(audio);
Spectralskewness_Mean = mean(mirgetdata(spectral_skewness));

% 30. Spectral Kurtosis Mean
spectral_kurtosis = mirkurtosis(audio);
Spectralkurtosis_Mean = mean(mirgetdata(spectral_kurtosis));

% 31. Spectral Flatness Mean
spectral_flatness = mirflatness(audio);
Spectralflatness_Mean = mean(mirgetdata(spectral_flatness));

% 32. Entropy of Spectrum Mean
entropy_spectrum = mirentropy(audio);
EntropyofSpectrum_Mean = mean(mirgetdata(entropy_spectrum));

% 33-44. Chromagram Mean (1-12)
chromagram = mirchromagram(audio);
chromagram_data = mirgetdata(chromagram);
for i = 1:12
    eval(['Chromagram_Mean_', num2str(i), ' = mean(chromagram_data(', num2str(i), ',:));']);
end

% 45. Harmonic Change Detection Function Mean
hcdf = mirhcdf(audio);
HarmonicChangeDetectionFunction_Mean = mean(mirgetdata(hcdf));

% 46. Harmonic Change Detection Function Std
HarmonicChangeDetectionFunction_Std = std(mirgetdata(hcdf));

% Manual computation of Harmonic Change Detection Function Slope using polyfit
hcdf_data = mirgetdata(hcdf);
time_hcdf = (1:length(hcdf_data))';
p_hcdf = polyfit(time_hcdf, hcdf_data, 1);
HarmonicChangeDetectionFunction_Slope = p_hcdf(1);

% 48. Harmonic Change Detection Function Period Frequency, Period Amplitude, Period Entropy
% The 'Periodicity' option was causing an error, so we will remove it
hcdf_data = mirgetdata(hcdf); % Just retrieve the HCDF data without periodicity-specific features
HarmonicChangeDetectionFunction_PeriodFreq = NaN;  % Set as NaN since 'Periodicity' was removed
HarmonicChangeDetectionFunction_PeriodAmp = NaN;   % Set as NaN
HarmonicChangeDetectionFunction_PeriodEntropy = NaN; % Set as NaN

% Create a table of the extracted features
feature_table = table(...
    RMSenergy_Mean, Lowenergy_Mean, Fluctuation_Mean, Tempo_Mean, ...
    MFCC_Mean_1, MFCC_Mean_2, MFCC_Mean_3, MFCC_Mean_4, MFCC_Mean_5, ...
    MFCC_Mean_6, MFCC_Mean_7, MFCC_Mean_8, MFCC_Mean_9, MFCC_Mean_10, ...
    MFCC_Mean_11, MFCC_Mean_12, MFCC_Mean_13, Roughness_Mean, Roughness_Slope, ...
    Zero_crossingrate_Mean, AttackTime_Mean, AttackTime_Slope, Rolloff_Mean, ...
    Eventdensity_Mean, Pulseclarity_Mean, Brightness_Mean, Spectralcentroid_Mean, ...
    Spectralspread_Mean, Spectralskewness_Mean, Spectralkurtosis_Mean, Spectralflatness_Mean, ...
    EntropyofSpectrum_Mean, Chromagram_Mean_1, Chromagram_Mean_2, Chromagram_Mean_3, ...
    Chromagram_Mean_4, Chromagram_Mean_5, Chromagram_Mean_6, Chromagram_Mean_7, ...
    Chromagram_Mean_8, Chromagram_Mean_9, Chromagram_Mean_10, Chromagram_Mean_11, ...
    Chromagram_Mean_12, HarmonicChangeDetectionFunction_Mean, HarmonicChangeDetectionFunction_Std, ...
    HarmonicChangeDetectionFunction_Slope);

% Export the table to a CSV file
writetable(feature_table, 'extracted_features.csv');

% Display completion message
disp('Feature extraction and export to CSV complete.');
