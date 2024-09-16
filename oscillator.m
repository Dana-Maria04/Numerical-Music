function x = oscillator(freq, fs, dur, A, D, S, R)
    x = 0;
    % Generam unda sinusoidala
    num_samples = round(dur * fs);
    time_vector = (0:num_samples-1) / fs;
    sine_wave = sin(2 * pi * freq * time_vector);
    
    % Generam envelope-ul ADSR
    num_attack_samples = int64(floor(A * fs));
    num_decay_samples = int64(floor(D * fs));
    num_release_samples = int64(floor(R * fs));
    num_sustain_samples = max(0, num_samples - num_attack_samples - num_decay_samples - num_release_samples);

    env_attack = linspace(0, 1, double(num_attack_samples));
    env_decay = linspace(1, S, double(num_decay_samples));
    env_sustain = S * ones(1, num_sustain_samples);
    env_release = linspace(S, 0, double(num_release_samples));

    envelope = [env_attack env_decay env_sustain env_release];
    
    % Normalizam envelope-ul
    if length(envelope) > num_samples
        envelope = envelope(1:num_samples);
    elseif length(envelope) < num_samples
        envelope = [envelope zeros(1, num_samples - length(envelope))];
    endif

    % Inmultim unda sinusoidala cu envelope-ul
    x = sine_wave .* envelope;
    x = x(:);
endfunction