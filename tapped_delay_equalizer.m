clc;
clear all;
close all;
syms t;
pr_t=input('enter distorted pulse as a function of t:');
Tb=input('enter bit duration:');
N=input('enter order of the filter N:');
mat=zeros(2*N+1,2*N+1);
for i=1:2*N+1
 for j=1:2*N+1
 mat(i,j)=subs(pr_t,i-j+1E-9);
 end
end
po_n=zeros(2*N+1,1);
po_n(N+1)=1;
c=mat\po_n;
disp('filter coefficients:');
disp(c);
po_t=0;
for i=-N:N
 po_t=po_t+c(i+N+1)*subs(pr_t,t-i*Tb);
end
t1=[-N:0.001:N]*Tb+1E-9;
n1=[-N:N]+1E-9;
figure;
subplot(2,1,1)
plot(t1,subs(pr_t,t1),'r','linewidth',1.5);
xlabel('time(s)');ylabel('amplitude(V)');title('received signal');grid on;
subplot(2,1,2)
plot(t1,subs(po_t,t1),'b','linewidth',1.5);
xlabel('time(s)');ylabel('amplitude(V)');title('equalized signal');grid on;
figure;
subplot(2,1,1)
stem([-N:N],subs(pr_t,n1),'r','linewidth',1.5);
xlabel('sample index');ylabel('amplitude(V)');title('sampled received signal');grid on;
subplot(2,1,2)
stem([-N:N],po_n,'b','linewidth',1.5);
xlabel('sample index');ylabel('amplitude(V)');title('sampled equalized signal');grid on;