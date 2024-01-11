clc;
close all;
t=0:2*pi/100:2*pi;
x=5*sin(2*pi*t/5);
subplot(3,1,1);
plot(x)
xlabel('Time')
ylabel('amplitude')
title('Original signal')
hold on

y=[0];
xr=0;
del=0.4;
for i=1:length(x)-1
    if xr(i)<=x(i)
        d=1;
        xr(i+1)=xr(i)+del;
    else
        d=0;
        xr(i+1)=xr(i)-del;
    end
    y=[y d];
end

stairs(xr)
hold off;

subplot(3,1,2);
stairs(y);
xlabel('Time')
ylabel('amplitude')
title('DM signal')

rx=zeros(length(y));
for i=1:length(y)-1
    if y(i)==1
        rx(i+1)=rx(i)+del;
    elseif y(i)==0
        rx(i+1)=rx(i)-del;
    end
end
subplot(3,1,3);
ddm=lowpass(rx,0.1,100);
stairs(ddm)
xlabel('Time')
ylabel('amplitude')
title('Recovered signal')
