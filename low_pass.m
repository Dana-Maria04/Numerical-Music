function filtered_signal = low_pass(signal, fs, cutoff_freq)
    % Calculam Transformata Fourier a semnalului
    transformed_signal = fft(signal);

    % Calculam toate frecventele posibile ale semnalului
    signal_length = length(signal);
    frequency_vector = (0:signal_length-1) * (fs / signal_length);

    % Cream o masca vectoriala pentru a selecta frecventele sub pragul de cutoff
    frequency_mask = frequency_vector <= cutoff_freq;

    % Aplic produsul Hadamard 
    filtered_transformed_signal = transformed_signal .* frequency_mask';

    % Calculam semnalul filtrat
    filtered_signal = ifft(filtered_transformed_signal);

    % Normalizam
    filtered_signal = filtered_signal / max(abs(filtered_signal));
endfunction