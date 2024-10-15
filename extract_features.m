function extract_features(file, output_csv)
    % Check if the file exists
    if ~isfile(file)
        error('File does not exist: %s', file);
    end

    % Load audio file using audioread (works for .wav and .mp3 files)
    [data, fs] = audioread(file); % 'data' is the audio signal, 'fs' is the sampling rate

    % If the audio has two channels (stereo), convert it to mono
    if size(data, 2) > 1
        data = mean(data, 2); % Average the two channels to create a mono signal
    end

    % Use the audio signal with MIRtoolbox
    audio = miraudio(data, fs); % Convert audio data into MIRtoolbox format

    % Extract features
    try
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
        MFCC_Mean = mean(mfcc_data, 2); % Compute mean along the 2nd dimension

        % 18. Roughness Mean
        roughness = mirroughness(audio);
        Roughness_Mean = mean(mirgetdata(roughness));

        % Roughness Slope (manual calculation using polyfit)
        roughness_data = mirgetdata(roughness);
        time_roughness = (1:length(roughness_data));
        p_roughness = polyfit(time_roughness, roughness_data, 1); % 1st-degree polynomial fit
        Roughness_Slope = p_roughness(1); % The slope is the first coefficient

        % 20. Zero-crossing rate Mean
        zcr = mirzerocross(audio);
        Zero_crossingrate_Mean = mean(mirgetdata(zcr));

        % 21. Attack Time Mean
        attack_time = mirattacktime(audio);
        AttackTime_Mean = mean(mirgetdata(attack_time));

        % Attack Time Slope (manual calculation using polyfit)
        attack_time_data = mirgetdata(attack_time);
        time_attack = (1:length(attack_time_data));
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
        Chromagram_Mean = mean(chromagram_data, 2); % Compute mean along 2nd dimension

        % 45. Harmonic Change Detection Function Mean
        hcdf = mirhcdf(audio);
        HarmonicChangeDetectionFunction_Mean = mean(mirgetdata(hcdf));

        % 46. Harmonic Change Detection Function Std
        HarmonicChangeDetectionFunction_Std = std(mirgetdata(hcdf));

        % Harmonic Change Detection Function Slope (manual calculation)
        hcdf_data = mirgetdata(hcdf);
        time_hcdf = (1:length(hcdf_data));
        p_hcdf = polyfit(time_hcdf, hcdf_data, 1);
        HarmonicChangeDetectionFunction_Slope = p_hcdf(1);

        % Create a table of the extracted features
        feature_table = table(...
            RMSenergy_Mean, Lowenergy_Mean, Fluctuation_Mean, Tempo_Mean, ...
            MFCC_Mean(1), MFCC_Mean(2), MFCC_Mean(3), MFCC_Mean(4), MFCC_Mean(5), ...
            MFCC_Mean(6), MFCC_Mean(7), MFCC_Mean(8), MFCC_Mean(9), MFCC_Mean(10), ...
            MFCC_Mean(11), MFCC_Mean(12), MFCC_Mean(13), Roughness_Mean, Roughness_Slope, ...
            Zero_crossingrate_Mean, AttackTime_Mean, AttackTime_Slope, Rolloff_Mean, ...
            Eventdensity_Mean, Pulseclarity_Mean, Brightness_Mean, Spectralcentroid_Mean, ...
            Spectralspread_Mean, Spectralskewness_Mean, Spectralkurtosis_Mean, Spectralflatness_Mean, ...
            EntropyofSpectrum_Mean, Chromagram_Mean(1), Chromagram_Mean(2), Chromagram_Mean(3), ...
            Chromagram_Mean(4), Chromagram_Mean(5), Chromagram_Mean(6), Chromagram_Mean(7), ...
            Chromagram_Mean(8), Chromagram_Mean(9), Chromagram_Mean(10), Chromagram_Mean(11), ...
            Chromagram_Mean(12), HarmonicChangeDetectionFunction_Mean, HarmonicChangeDetectionFunction_Std, ...
            HarmonicChangeDetectionFunction_Slope);

        % Export the table to a CSV file
        writetable(feature_table, output_csv);

        % Display completion message
        disp('Feature extraction and export to CSV complete.');

    catch ME
        disp('An error occurred during feature extraction:');
        disp(ME.message);
    end
end
