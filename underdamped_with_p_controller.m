clc;
clear all;
close all;
wn=2;
zeta=0.3;
kp=2;
s=tf('s');
s1=(kp*wn^2)/(s^2+2*wn*zeta*s+(kp*wn^2));
stepplot(s1);