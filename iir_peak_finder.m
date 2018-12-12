function pitch = iir_peak_finder(signal,freq_begin,freq_stop,fs,bandwith_hz)
%filters the input signal from the range of frequencies
max_value = 0;
for freq = freq_begin:freq_stop
   [a,b] = peak_iir_filter(freq,bandwith_hz,fs); %recebe os parametros do filtro para a frequencia especificada
   filtered_signal = filter(a,b,signal); %filtra o sinal
   max_filtered_signal_component = max(filtered_signal(1,:)); %pega a maior componente do sinal filtrado
   if max_filtered_signal_component > max_value %verifica se essa é a maior já encontrada, se sim, a frequencia é a fundamental
       pitch = freq;
       max_value = max_filtered_signal_component;
   end
end
end