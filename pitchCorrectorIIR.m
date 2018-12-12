%%Fun��o que realiza a corre��o dos tons
%%Recebe como entrada a STFT, a frequencia de busca para os tons, a tabela
%%com os tons, a frequencia de amostragem e a banda utilizada para o filtro
%%de pico IIR

function S_corrected = pitchCorrectorIIR(S,freq_begin,freq_stop,pitchtable,fs,bandwith_hz)
bins = length(S(1,:));
S_len = length(S(:,1));

%%Pre aloca memorias para os vetores
maxpeaks = zeros(1,bins);
indices = zeros(1,bins);
pitches = zeros(1,bins);
correctedpitches = zeros(1,bins);
ratio = zeros(1,bins);
S_corrected = zeros(S_len,bins);

%retorna uma tabela de tons encontrados para cada janela do sinal da stft
pitches = iir_pitches_finder(S,freq_begin,freq_stop,fs,bandwith_hz);
for k=1:bins
    correctedpitches(k) = compareToPitches(pitches(k), pitchtable);
    ratio(k) = correctedpitches(k)/pitches(k);
end

%%A rela��o entre frequencias deve ser equivalente a rela��o entre amostras. Se a rela��o
%% for maior que um S-corrected ser� completado com zeros, se a rela��o for menor que 1
%% o S-corrected ter� valores repetidos. Fazendo com que tenha perda ad informa��o.

for k = 1:bins
        for j = 1:S_len
          y = round(j/ratio(k));
          
          %%Prevents negative indices
          if y < 1 
              y = 1;
          end
          
          %%Non-constant frequency scaling
          if y <= S_len
            S_corrected(j,k) = S((y),k);
          end
        end
end

end

