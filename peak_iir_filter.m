function [a,b] = peak_iir_filter(fcenter,bw_hz,fs)
%Creates the peak iir filter in the center frequency with the desired
%bandwith in hz
Fs = fs; Wo = fcenter/(Fs/2);  BW = bw_hz/(Fs/2);
[a,b] = iirpeak(Wo,BW);
end