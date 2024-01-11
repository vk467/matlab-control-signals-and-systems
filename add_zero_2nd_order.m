clc;
clear all;
close all;

wn=2;
zeta=0.3;
s=tf('s');
a=0;
s1=((wn^2)*(s*a+1))/(s^2+2*wn*zeta*s+wn^2);
a=0.3;
s2=((wn^2)*(s*a+1))/(s^2+2*wn*zeta*s+wn^2);
a=0.5;
s3=((wn^2)*(s*a+1))/(s^2+2*wn*zeta*s+wn^2);
a=1;
s4=((wn^2)*(s*a+1))/(s^2+2*wn*zeta*s+wn^2);

stepplot(s1,s2,s3,s4);
