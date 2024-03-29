clc;
close all;
clear all;
x=input('Enter the sequence x= ');
N=input('Enter the length of the DFT N= ');
len=length(x);
if N>len
    x=[x zeros(1,N-len)];
elseif N<len
    x=x(1:N);
end
% N=length(x);
i=sqrt(-1);
w=exp(-i*2*pi/N);
n=0:(N-1);
k=0:(N-1);
nk=n'*k;
W=w.^nk;
X=x*W;
disp(X);
subplot(211);
stem(k,abs(X));
title('Magnitude Spectrum');
xlabel('Discrete frequency');
ylabel('Amplitude');
grid on;
subplot(212);
stem(k,angle(X));
title('Phase Spectrum');
xlabel('Discrete frequency');
ylabel('Phase Angle');
grid on;