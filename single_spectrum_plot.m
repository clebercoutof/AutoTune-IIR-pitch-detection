function single_spectrum_plot(signal,fs)
%plota o espectro de um sinal
signal_for_fft = signal;

N = length(signal_for_fft);%numero de amostras para fft
signal_fft = fft(signal_for_fft,N); %transformada do sinal
%configurações para plot
P2=2*abs(signal_fft/N);
P1=P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(N/2))/N;
stem(f,P1);
title('Single sided spectrum');

end