function [S F T Y] = quickSpectrogram(wave,winsize,nfft,hpsonoff)
%%Quick spectrogram function with HPS ability and certain preset arguments

[S,F,T]=spectrogram(wave, hanning(winsize), winsize/2, nfft, 44100);
bins = length(S(1,:));

if (hpsonoff ~= 0)
    Y = abs(S);
    for i = 1:bins;
        Y(:,i) = hps(Y(:,i));
    end
    displaySpectrogram(Y, F, T);
else
Y = displaydBSpectrogram(S, F, T);
end

end