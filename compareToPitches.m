%%A fun��o recebe um tom e a tabela contadndo a escola de tons, retornando o tom mais pr�ximo da escala
function exactpitch = compareToPitches(pitch, pitchtable)

%%Organiza a tabela em ordem crescente
sortedpitchtable = sort(pitchtable); 

%%Cria vetor de zeros
midpitchtable = zeros(1,length(sortedpitchtable)-1);

%%V�riavel que indica se o tom mais pr�ximo foi encontrado
found = 0;

%%Gera uma tabela de tons na m�dia dos tons da tabela de tons para tornar a compara��o
%%mais f�cil.
%%log2(0.5) � utilizado 0.5 afim de contabilizar para percep��o do som
for i = 1:(length(sortedpitchtable)-1)
    midpitchtable(i) = (sortedpitchtable(i+1) - sortedpitchtable(i))*log2(0.5) + sortedpitchtable(i);
end

%%Caso a frequ�ncia seja menor que o menor tom da tabela, ele � retornado
%%imediatamente
if (pitch <= midpitchtable(1))
    exactpitch = sortedpitchtable(1);
    found = 1;
end

%%Se o tom exato n�o fo encontrado ainda considera o maior tom da tabela
if (found==0)
    if (pitch > midpitchtable(length(midpitchtable)))
        exactpitch = sortedpitchtable(length(sortedpitchtable));
        found = 1;
    end
end

%%Se o tom exato n�o foi encontrado ainda, compare o a todos os valores
%da midpitchtable e a sa�da corresponde ao tom na tabela de tom 
i = 1;
while(found==0)
    if(pitch > midpitchtable(i) && pitch <= midpitchtable(i+1))
        exactpitch = sortedpitchtable(i+1);
        found=1;
    end
    i = i+1;
end

end