clc;
clear all;
close all;
t=0:0.1:30;
u=zeros(1,length(t));
c1=u; c2=u; c3=u; c4=u; c5=u; 
for i=1:301
        u(i)=1; 
end

[wd1,t1]=underdamp(0.25,0.3);  %Wn=0.25, zeta=0.3 ->under damped
for i=1:301
    c1(i)=(1-((exp(-0.3*0.25*t(i))*sin(wd1*t(i)+t1))/(sqrt(1-(0.3^2)))))*u(i); 
end

[wd2,t2]=underdamp(0.5,0.3);  %Wn=0.5, zeta=0.3 ->under damped
for i=1:301
    c2(i)=(1-((exp(-0.3*0.5*t(i))*sin(wd2*t(i)+t2))/(sqrt(1-(0.3^2)))))*u(i); 
end

[wd3,t3]=underdamp(1,0.3);  %Wn=1, zeta=0.3 ->under damped
for i=1:301
    c3(i)=(1-((exp(-0.3*1*t(i))*sin(wd3*t(i)+t3))/(sqrt(1-(0.3^2)))))*u(i); 
end

[wd4,t4]=underdamp(2,0.3);  %Wn=2, zeta=0.3 ->under damped
for i=1:301
    c4(i)=(1-((exp(-0.3*2*t(i))*sin(wd4*t(i)+t4))/(sqrt(1-(0.3^2)))))*u(i); 
end

[wd5,t5]=underdamp(5,0.3);  %Wn=5, zeta=0.3 ->under damped
for i=1:301
    c5(i)=(1-((exp(-0.3*5*t(i))*sin(wd5*t(i)+t5))/(sqrt(1-(0.3^2)))))*u(i); 
end

plot(t,c1,t,c2,t,c3,t,c4,t,c5,'linewidth',2)
grid minor
ylim([-0.2 1.8])
xlabel('t ->')
ylabel('c(t) ->')