clc;
close all;
clear all;
x = input('Enter the sequence for FFT = ');
N = length(x);
t = 0:N-1;

y=FFT_DIF_R2(x);
disp('FFT (Decimation in Frequency): ');
disp(y);
subplot(411)
stem(t,abs(y));
xlabel('n -->');
ylabel('Magnitude');
title('DIF')

subplot(412)
stem(t,angle(y));
xlabel('n -->');
ylabel('Phase');
title('DIF')

y2=FFT_DIT_R2(x);
disp('FFT (Decimation in Time): ');
disp(y2);
subplot(413)
stem(t,abs(y2));
xlabel('n -->');
ylabel('Magnitude');
title('DIT')

subplot(414)
stem(t,angle(y2));
xlabel('n -->');
ylabel('Phase');
title('DIT')

y3=fft(x);
disp('FFT using built in function: ');
disp(y3);

% N = length(x); %finding the length of entered sequence for N point FFT
% 
% for k = 1:N %for every value of k
% y(k) = 0;
% for n = 1:N %for every value of n
% y(k) = y(k)+x(n)*exp(-1i*2*pi*(k-1)*(n-1)/N);
% %as per FFT formula 0 to n-1
% end
% end