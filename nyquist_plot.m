clc;
clear all;
num=[18];
den=[1 5 4 0];
sys=tf(num,den);
allmargin(sys)
nyquist(sys);
