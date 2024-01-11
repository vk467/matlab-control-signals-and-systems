%IIR Filter using Butterworth Approximation CT filter design and Impulse
%invaraince tranformation to design Low pass DT filter
%CT low pass filter design with pass band frequency 20 rad/s and stop band
%frequency 30 rad/s with respective ripple gains of -2dB and -10dB 
%Finding minimum order of the CT filter using buttord
clc;
clear all;
close all;
Wp=input('Enter the pass frequnecy:');
Ws=input('Enter the stop frequency:');
K1=input('Gain in dB for pass frequency:');
K2=input('Gain in dB for stop frequnecy:');
[N,wn]=buttord(Wp,Ws,K1,K2,'s');
[b,a]=butter(N,wn,'low','s');

disp('Transfer function');
tf(b,a)

%frequency response of the CT filter design
f1=figure;
freqs(b,a,logspace(0,10));


Fs=input('sampling frequnecy in order to design DT filter:');

[bz,az]=bilinear(b,a,Fs);
f2=figure;
freqz(bz,az);

[b_z,a_z]=impinvar(b,a,Fs);
f3=figure;
freqz(b_z,a_z);
