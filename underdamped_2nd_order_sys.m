clc;
clear all;
close all;
wn=2;
zeta=0.3;
s=tf('s');
s1=wn^2/(s^2+2*wn*zeta*s+wn^2);
stepplot(s1);
t=logspace(-1,1,100);
bode(s1,t);
