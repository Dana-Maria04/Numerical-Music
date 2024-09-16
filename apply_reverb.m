function signal = apply_reverb(signal, impulse_response)
  % signal = 0;

  % Verificam daca impulse_response este stereo (are doua coloane)
  if size(impulse_response, 2) > 1
    impulse_response = stereo_to_mono(impulse_response);
  endif

  % Convolutia semnalului cu raspunsul la impuls
  signal = fftconv(signal, impulse_response);

  % Normalizarea semnalului
  signal = signal / max(abs(signal));
endfunction