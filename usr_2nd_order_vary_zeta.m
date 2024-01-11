clc;
clear all;
close all;
t=0:0.1:30;
u=zeros(1,length(t));
c1=u; c2=u; c3=u; c4=u; c5=u; c6=u;
for i=1:301
        u(i)=1; 
end

[wd1,t1]=underdamp(1,0.1);  %Wn=1, zeta=0.1 ->under damped
for i=1:301
    c1(i)=(1-((exp(-0.1*1*t(i))*sin(wd1*t(i)+t1))/(sqrt(1-(0.1^2)))))*u(i); 
end

[wd2,t2]=underdamp(1,0.3);  %Wn=1, zeta=0.3 ->under damped
for i=1:301
    c2(i)=(1-((exp(-0.3*1*t(i))*sin(wd2*t(i)+t2))/(sqrt(1-(0.3^2)))))*u(i); 
end

[wd3,t3]=underdamp(1,0.6);  %Wn=1, zeta=0.6 ->under damped
for i=1:301
    c3(i)=(1-((exp(-0.6*1*t(i))*sin(wd3*t(i)+t3))/(sqrt(1-(0.6^2)))))*u(i); 
end

[wd4,t4]=underdamp(1,0.9);  %Wn=1, zeta=0.9 ->under damped
for i=1:301
    c4(i)=(1-((exp(-0.9*1*t(i))*sin(wd4*t(i)+t4))/(sqrt(1-(0.9^2)))))*u(i); 
end

[wd5,t5]=underdamp(1,3);  %Wn=1, zeta=3 ->under damped
for i=1:301
    c5(i)=(1-((exp(-3*1*t(i))*sin(wd5*t(i)+t5))/(sqrt(1-(3^2)))))*u(i); 
end

[wd6,t6]=underdamp(1,5);  %Wn=1, zeta=5 ->under damped
for i=1:301
    c6(i)=(1-((exp(-5*1*t(i))*sin(wd6*t(i)+t6))/(sqrt(1-(5^2)))))*u(i); 
end

plot(t,c1,t,c2,t,c3,t,c4,t,c5,t,c6,'linewidth',2)
grid minor
xlabel('t ->')
ylabel('c(t) ->')