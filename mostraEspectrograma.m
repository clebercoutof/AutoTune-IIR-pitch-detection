function Y = mostraEspectrograma(S,F,T)
%%Mostra o spectrograma do sinal S, recebendo o vetor de frequência F e o vetor de tempo T

X = abs(S);
imagesc(T,F,S);  
colorbar;
axis xy
xlabel('Time (s)')
ylabel('Freq (Hz)')

end