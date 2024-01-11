clearvars; 
close all;
clc;

volt=5;
data = input('data vector: ')

n = length(data);
x = [];
unipolar = [];
nrzL = [];
nrzI = [];
polarRZ = [];
manchester=[];
diffmanch=[];
clk=[];
stream=[];


for i=1:n
    x=[x i-1 i-1+0.5 i-1+0.5 i];
    clk=[clk 1 1 0 0];
end

for i=1:n
    if(data(i)==0)
        stream=[stream 0 0 0 0];
    else
        stream=[stream 1 1 1 1];
    end
end

for i=1:n
    if(data(i)==0)
        unipolar=[unipolar 0 0 0 0];
    else
        unipolar=[unipolar volt volt volt volt];
    end
end

for i=1:n
    if(data(i)==0)
        nrzL=[nrzL volt volt volt volt];
    else
        nrzL=[nrzL -volt -volt -volt -volt];
    end
end

a=volt;
for i=1:n
    if(data(i)==1)
        nrzI=[nrzI -a -a -a -a];
    else
        nrzI=[nrzI a a a a];
    end
    a=nrzI(length(nrzI));
end

for i=1:n
    if(data(i)==0)
        polarRZ=[polarRZ -volt -volt 0 0];
    else
        polarRZ=[polarRZ volt volt 0 0];
    end
end

for i=1:n
    if(data(i)==0)
        manchester=[manchester volt volt -volt -volt];
    else
        manchester=[manchester -volt -volt volt volt];
    end
end

a=volt;
for i=1:n
    if(data(i)==0)
        diffmanch=[diffmanch -a -a a a];
    else
        diffmanch=[diffmanch a a -a -a];
    end
    a=diffmanch(length(diffmanch));
end


subplot(411);
plot(x,clk,'LineWidth',2.5); title('Clock'); xlabel('time'); ylabel('Clock Pulse');
subplot(412);
plot(x,stream,'LineWidth',2.5); xlabel('time'); ylabel('Bit'); title('Data');
subplot(413);
plot(x,unipolar,'LineWidth',2.5); title('Unipolar NRZ'); xlabel('time'); ylabel('Amplitude');
subplot(414);
plot(x,nrzL,'LineWidth',2.5); title('Polar NRZ-L'); xlabel('time'); ylabel('Amplitude');

figure;
subplot(411);
plot(x,nrzI,'LineWidth',2.5); title('Polar NRZ-I'); xlabel('time'); ylabel('Amplitude');
subplot(412);
plot(x,polarRZ,'LineWidth',2.5);title('Polar RZ');xlabel('time'); ylabel('Amplitude');
subplot(413);
plot(x,manchester,'LineWidth',2.5); title('Manchester'); xlabel('time'); ylabel('Amplitude');
subplot(414);
plot(x,diffmanch,'LineWidth',2); title('Differential Manchester'); xlabel('time'); ylabel('Amplitude');

f=0:0.01:1;
Tb=1;
a=volt;
x1=(sinc(f*Tb)).^2;
x2=x1*Tb*((a^2)/4);
x=x1*Tb*(a^2);
z=(f==0);
z1=((a^2)/4)*z;
x_2=x2+z1;
v=(sin(pi*f*Tb).^2);
x_3=x.*v;
vm=(sinc(f*Tb/2)).^2;
vm1=(sin(pi*f*Tb/2).^2);
x_4=(a^2)*Tb*vm.*vm1;
figure;
plot(f,x);
xlabel('Frequency(Hz)'); ylabel('Power Spectral Density'); title('NRZ-Polar');
figure;
plot(f,x_2);
xlabel('Frequency(Hz)'); ylabel('Power Spectral Density'); title('NRZ-UniPolar');
figure;
plot(f,x_3);
xlabel('Frequency(Hz)'); ylabel('Power Spectral Density'); title('NRZ-BiPolar');
figure;
plot(f,x_4);
xlabel('Frequency(Hz)');ylabel('Power Spectral Density');title('Manchester');
