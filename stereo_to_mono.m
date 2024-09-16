function mono = stereo_to_mono(stereo)
  mono = stereo;
  % Copiem semnalul stereo in mono
  
  mono = mean(mono, 2);
  % Calculam media semnalului stereo pe cele doua canale
  
  % Normalizam semnalul
  mono = mono / max(abs(mono));
endfunction