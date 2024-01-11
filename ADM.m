close all;
clc;
clear all;

t=0:2*pi/100:5*pi;
A=4;
x=A*sin(t);

plot(x)
hold on

ADMout = adeltamod(x, 1, 0.1,0.3);
plot(ADMout);
xlabel('time');
ylabel('Amplitude');
legend('Original signal','ADM output')