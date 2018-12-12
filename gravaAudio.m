function audio = gravaAudio(fs,duration)
%Cria um objeto do tipo audio recorder com uma frequência de amostragem fs, 16 bit, canal mono 
recorder = audiorecorder(fs,16,1);
 record(recorder);
 pause(duration);
 
 audio = getaudiodata(recorder);
end