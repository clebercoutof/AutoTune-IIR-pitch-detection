function Y = displaydBSpectrogram(S,F,T)
%%Quick function to display the spectrogram of a given STFT
%%uimagesc is used so that the axes can have non-linear spacing
figure
X = abs(S);
Y = 20*log10(X/min(X(:)));
imagesc(T,F,Y);  
colorbar;
axis xy
xlabel('Time (s)')
ylabel('Freq (Hz)')

end