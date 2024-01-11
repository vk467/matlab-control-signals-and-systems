clear all;
close all;
clc;
fm=4;
fs=20*fm;
am=2;
t=0:1/fs:1;
x=am*cos(2*pi*fm*t);
figure(1);
subplot(2,1,1)
plot(t,x,'r-');
hold on;
xlabel('Time');
ylabel('Amplitude');
title('Input sinusoidal signal');
for n=1:length(x)
    if n==1
        e(n)=x(n);
        eq(n)=round(e(n));
        xq(n)=eq(n);
    else
        e(n)=x(n)-xq(n-1);
        eq(n)=round(e(n));
        xq(n)=eq(n)+xq(n-1);
    end
end

for n=1:length(x)
    if n==1
        xqr(n)=eq(n);
    else
        xqr(n)=eq(n)+xqr(n-1);
    end
end
subplot(2,1,2)
plot(t,xqr,'b-');
xlabel('Time');
ylabel('Amplitude');
title('Reconstructed signal');