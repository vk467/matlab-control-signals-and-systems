clc;
clear all;
close all;
t=0:10;
u=zeros(1,length(t));
c=u;
ctr=u;
for i=1:11
        u(i)=1; 
end
for i=1:11
    ctr(i)=exp(-t(i));
end
for i=1:11
    c(i)=u(i)-ctr(i);
end

subplot(2,2,1)
plot(t,u)
title("r(t)")
subplot(2,2,2)
plot(t,c)
title("C(t)")
subplot(2,2,3)
plot(t,u)
title("Css(t)")
subplot(2,2,4)
plot(t,ctr)
title("Ctr(t)")
