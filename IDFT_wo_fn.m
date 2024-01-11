clc;
close all;
clear all;
x=input('Enter the sequence x= ');
N=length(x);
ixk = zeros(1,N);
for n = 0:N-1
    for k = 0:N-1
        ixk(n+1) = ixk(n+1)+(x(k+1)*exp(1i*2*pi*k*n/N));
    end
end
ixk = ixk./N;
%code block to plot the IDFT sequence
t = 0:N-1;
stem(t,abs(ixk));
disp('IDFT Sequence = ');
disp(ixk);
ylabel('Amplitude ---->');
xlabel('n ---->');
title('IDFT sequence ---->');
grid on;
