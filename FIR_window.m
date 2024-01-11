clc;
clear all;
close all;

N=input('Enter order N: ');
wn=input('Enter Wn: ');

b = fir1(N,wn,'low',gausswin(N+1,2.5));
f1= figure;
freqz(b,1,512)
f2=figure;
impz(b)

b = fir1(N,wn,'low',blackman(N+1));
f3= figure;
freqz(b,1,512)
f4=figure;
impz(b)

b = fir1(N,wn,'low',rectwin(N+1));
f5= figure;
freqz(b,1,512)
f6=figure;
impz(b)
