function [S, f, t] = spectrogram(signal, fs, window_size)
    % initializam variabilele
    signal_length = length(signal);
    num_segments = floor(signal_length / window_size);

    S = zeros(window_size, num_segments);
    f = zeros(window_size, 1);
    t = zeros(num_segments, 1);

    % Calculam spectrograma
    segment_index = 1;
    % Calculam spectrul pentru fiecare segment
    while segment_index <= num_segments
        start_index = (segment_index - 1) * window_size + 1;
        end_index = start_index + window_size - 1;
        segment = signal(start_index:end_index);

    % Aplicam fereastra Hanning
        windowed_segment = segment .* hanning(window_size);
        segment_fft = fft(windowed_segment, window_size * 2);
        segment_fft = segment_fft(1:window_size);

    % Salvam spectrul segmentului
        S(:, segment_index) = abs(segment_fft);
        segment_index = segment_index + 1;
    endwhile

    freq_index = 1;
    % Realizam vectorul de frecvente
    while freq_index <= window_size
        f(freq_index) = (freq_index - 1) * (fs / (2 * window_size));
        freq_index = freq_index + 1;
    endwhile

    % Realizam vectorul de timp
    time_index = 1;
    while time_index <= num_segments
        t(time_index) = (time_index - 1) * (window_size / fs);
        time_index = time_index + 1;
    endwhile
endfunction