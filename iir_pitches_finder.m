function pitches = iir_pitches_finder(S,freq_begin,freq_stop,fs,bandwith_hz)
%Retorna um vetor contendo o tom encontrao para cada janela da stft
%recebe o sinal, o range de frequencias para buscar, a frequencia de
%amostragem fs e a banda utilizada para o filtro de pico
bins = length(S(1,:));
S_len = length(S(:,1));

for k = 1:bins
    signal = istft(S(:,k));
    pitch = iir_peak_finder(signal,freq_begin,freq_stop,fs,bandwith_hz);
    pitches(k) = pitch;
end
end