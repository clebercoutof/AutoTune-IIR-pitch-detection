fs = 44100; %% Frequência de Amostragem
winsize = 4000; %% Tamanho da janela
NFFT = 4096; %% Número de amostras da stft
noverlap = 1000; %Número de amostras que não sofrerão overlap
audio_duration = 3; %Duração do áudio
window = hanning(winsize); %Janela a ser utilizada na stft

%%%%%%%%%%%%%%%%%%%%%Diferentes Entradas%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal = gravaAudio(fs,audio_duration); %teste utilizando sinal gravado por microfone 
%signal = generateWave(400,10000,fs,audio_duration,0); %teste utilizando onda gerada de frequencia variavel
%f = [400,150,100]; %frequencias das ondas geradas
%k = 400;
%dp = 1;
%c = 0; %plota no tempo/plot está comentado no código mas pode ser tirado
%para verificação
%theta = [0,120,160]; %fases 0
%amplitude = [2,3,1]; %amplitudes ( a fundamental é a com maior amplitude)
%signal = gera_seno(fs, f, k, dp, c, theta,amplitude);

%%%%%%%%%%%%%%%%%%%%%%Analise do sinal%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
freq_begin = 400;%frequencia para inicio da busca com filtro de pico
freq_stop = 10000; %frequencia para final da busca com filtro de pico
bandwith_hz =1;%banda de passagem para o filtro de pico

[signal_transformed F T P] = spectrogram(signal, window, noverlap, NFFT, fs);%faz a stft
displaydBSpectrogram(signal_transformed,F,T); %mostra spectograma do sinal antes de corrigir
sound_corrected = pitchCorrectorIIR(signal_transformed,freq_begin,freq_stop,tabelaDoMaior(),fs,bandwith_hz);
sound_corrected = conj(sound_corrected); % Faz o conjugado
isignal = istft(sound_corrected,NFFT,winsize,noverlap); % Faz a transformada inversa do sinal
[S F T Y] = quickSpectrogram(isignal,winsize,NFFT,0); %Função que realiza a stft e mostra o spectrograma do sinal corrigido
toc
sound(isignal,fs)%toca o som