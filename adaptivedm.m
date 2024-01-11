clc;           
clear all
close all;
t =0:1/29:1;
f=1;
x=4*sin(2*pi*f*t);
x=[x ones(1,10) x]; 
y = zeros(1,length(x));
d = zeros(1,length(x));
e= zeros(1,length(x));
s=0.1;
for i=5:length(x)
    if(x(i)-y(i-1))>=0
          y(i) = x(i)-s;
            d(i)=-1;
    elseif(x(i)-y(i-1))<0
    y(i)=x(i)-1;
    d(i)=-1;       
    end 


    if(sum(d(i-4:i)))>3
    s=s+0.01;
    elseif(sum(d(i-4:i)))<-3
      s=s+0.01;
    elseif(sum(d(i-4:i)))==0
    s=s-0.01;
    else
    s=s;
    end
    pause;
    subplot 211; 
    plot(x); 
    hold on;
    stem(y,'m');
    e=x-y;plot(e,'r');
    title('Input,tracking and error graph');
    subplot 212; 
    stem (d,'k'); 
    title('output data signal')
end