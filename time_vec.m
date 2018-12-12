function [t,length_signal] = time_vec(signal,fs)
    length_signal = length(signal);
    t = 0:1/fs:((length_signal-1)*1/fs);
end