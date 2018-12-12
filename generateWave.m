%This function creates and plays a glissando (frequency sweep) starting from
%fmin to fmax over the duration of sweeptime, with margintime specifying
%how much time the signal stays at fmin and fmax before and after the
%glissando (for the convenience of the listener.) The glissando is exponential so that it can be
%percieved as linear. fs is the sampling rate. All input times are in seconds, and all input frequencies are in Hz. The
%function also plots the DFT of the wave.
%If margins are nonzero, there will be audible clicking since the wave
%function is not continuous. Also outputs time indexing x.

function [wave x] = generateWave(fmin, fmax, fs, sweeptime, margintime)

%%This code was used to find the desired angular frequency function, 
%%which is the derivative of the argument of the sinusoid. The
%%expression in the sinusoid must then be the integral of the angular
%%frequency function.
%%
%%syms a b c x;
%%int(a*(b/a)^(x/c),x) %%This specifies an exponential function that starts at a and increases to b over time duration c
%%ans = (a*c*(b/a)^(x/c))/log(b/a)

totaltime = 2*margintime + sweeptime; %Total duration of the wave, in seconds
totalsamples = totaltime*fs; %Total duration of the wave, in samples
marginsamples = margintime*fs; %Duration of the margins, in samples
sweepsamples = sweeptime*fs; %Duration of the sweep, in samples

%%Generates sample indexing
x = linspace(0,totaltime,totalsamples);
xmargin = linspace(0,margintime,marginsamples);
xsweep = linspace(0,sweeptime,sweepsamples);

%%This code exists because linspace will return a vector of length 1 even
%%if all its arguments are 0
if(sweeptime == 0)
    xsweep = [];
end
if(margintime == 0)
    xmargin = [];
end

%%Pre-allocates memory for wave
wave = zeros(1,totalsamples);

%%Generates margin waveform 
if(margintime ~= 0)
    for i = 1:length(xmargin)
     wave(i) = sin(fmin*xmargin(i)*2*pi); %%Starting margin with frequency fmin
     wave(i+length(xmargin)+length(xsweep)) = sin(fmax*xmargin(i)*2*pi); %%Ending margin with frequency fmax
    end
end

%%Generates sweep waveform
if(sweeptime ~= 0)
    for i = 1:length(xsweep)
      %%Plugs in the integral of angular frequency function (x 2pi) using the user specified values into
      %%sin function
      wave(i+length(xmargin)) = sin((fmin*sweeptime*(fmax/fmin)^(xsweep(i)/sweeptime)/log(fmax/fmin))*2*pi);
    end
end

%[F Y T] = displayDFT(wave, fs);

%%Convenient axes scaling
%ymin = 0;
%ymax = max(Y);
%xmax = fmax+200;
%xmin = fmin-200;
%if (xmin-200)<0
%    xmin=0;
%end
%axis([xmin xmax ymin ymax]);

%%Plays waveform
%soundsc(wave, fs);
end

    