clc;
close all;
clear all;
x1=input('Enter the first sequence :');
x2=input('Enter the second sequence: ');
N1=length(x1);
N2=length(x2);
N=max(N1,N2);
 
if(N2>N1)
x4=[x1,zeros(1,N-N1)];
x5=x2;
elseif(N2==N1)
        x4=x1;
        x5=x2;
else
x4=x1;
x5=[x2,zeros(1,N-N2)];
end
 
x3=zeros(1,N);
for m=0:N-1
    x3(m+1)=0;
    for n=0:N-1
            j=mod(m-n,N);
            x3(m+1)=x3(m+1)+x4(n+1).*x5(j+1);
    end
end

disp('y:');
disp(x3);
subplot(4,1,1)
stem(x1);
title('First Input Sequence');
xlabel('Samples');
ylabel('Amplitude');
subplot(4,1,2)
stem(x2);
title('Second Input Sequence');
xlabel('Samples');
ylabel('Amplitude');
subplot(4,1,3)
stem(x3);
title('Circular Convolution UsingModulo Operator');
xlabel('Samples');
ylabel('Amplitude');
 
%In built function
y=cconv(x1,x2,N);
subplot(4,1,4)
stem(y);
title('Circular Convolution usingInbuilt Function');
xlabel('Samples');
ylabel('Amplitude');
