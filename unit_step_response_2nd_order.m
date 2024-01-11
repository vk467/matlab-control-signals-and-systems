clc;
clear all;
close all;
t=0:0.1:10;
u=zeros(1,length(t));
c=u;
c2=u;
c3=u;
c4=u;
for i=1:101
        u(i)=1; 
end
for i=1:101
    c(i)=(1-cos(2*t(i)))*u(i); % ->undamped
end
for i=1:101
    c2(i)=(1-(exp(-2*t(i))*(1+2*t(i))))*u(i); % Wn=2 ->critically damped
end
for i=1:101
    c3(i)=(1-((exp(-0.3*2*t(i))*sin(1.907*t(i)+1.266))/(sqrt(1-(0.3^2)))))*u(i); %Wn=2, zeta=0.3, Wd=1.907 ,theta=1.266 ->under damped
end
a=(3*2)+(2*sqrt((3^2)-1));
b=(3*2)-(2*sqrt((3^2)-1));
for i=1:101
    c4(i)=(1+((2/(2*sqrt((3^2)-1)))*((exp(-a*t(i))/a)-(exp(-b*t(i))/b))))*u(i); % Wn=2,zeta=3 ->over damped
end

plot(t,c,t,c2,t,c3,t,c4,'linewidth',2)
grid minor
xlabel('t ->')
ylabel('c(t) ->')