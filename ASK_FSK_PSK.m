clc;
clear all;
close all;
% b=input('Bits to be transmitted: ');
n=10000;
b=round(rand(1,n));
n=length(b);
f1=1;f2=2;
t=0:1/30:1-1/30;

%ASK
sa1=sin(2*pi*f1*t);
E1=sum(sa1.^2);
sa1=sa1/sqrt(E1); %unit energy 
sa0=0*sin(2*pi*f1*t);

%FSK
sf0=sin(2*pi*f1*t);
E=sum(sf0.^2);
sf0=sf0/sqrt(E);
sf1=sin(2*pi*f2*t);
E=sum(sf1.^2);
sf1=sf1/sqrt(E);

%PSK
sp0=-sin(2*pi*f1*t)/sqrt(E1);
sp1=sin(2*pi*f1*t)/sqrt(E1);

%DPSK
sdp0=sp0;

%QPSK
sq0 = sin(2*pi*f1*t)/sqrt(E1);
sq1 = sin(2*pi*f1*t+pi)/sqrt(E1);
sq2 = sin(2*pi*f1*t+pi/2)/sqrt(E1);
sq3 = sin(2*pi*f1*t-pi/2)/sqrt(E1);


%MODULATION
ask=[];psk=[];fsk=[];dpsk=[];
for i=1:n
    if b(i)==1
        ask=[ask sa1];
        psk=[psk sp1];
        fsk=[fsk sf1];
    else
        ask=[ask sa0];
        psk=[psk sp0];
        fsk=[fsk sf0];
    end
end
for i=1:n
    if b(i)==1
        sdp0 = -sdp0;
    end
    dpsk=[dpsk sdp0];
end

qpsk=[];
for i=1:2:n
    if b(i)==0 && b(i+1)==0
        qpsk=[qpsk sq0 sq0];
    elseif b(i)==0 && b(i+1)==1
        qpsk=[qpsk sq1 sq1];
    elseif b(i)==1 && b(i+1)==0
        qpsk=[qpsk sq2 sq2];
    elseif b(i)==1 && b(i+1)==1
        qpsk=[qpsk sq3 sq3];
    end
    
end


figure(1)
subplot(511)
stairs(0:9,b(1:10),'linewidth',1.5)
axis([0 10 -0.5 1.5])
title('Message Bits');grid on
xlabel('Time');ylabel('Amplitude')

subplot(512)
tb=0:1/30:10-1/30;
plot(tb, ask(1:10*30),'b','linewidth',1.5)
title('ASK Modulation');grid on
axis([0 10 -0.3 0.3])
xlabel('Time');ylabel('Amplitude')
subplot(513)
plot(tb, fsk(1:10*30),'r','linewidth',1.5)
title('FSK Modulation');grid on
axis([0 10 -0.3 0.3])
xlabel('Time');ylabel('Amplitude')
subplot(514)
plot(tb, psk(1:10*30),'k','linewidth',1.5)
title('PSK Modulation');grid on
axis([0 10 -0.3 0.3])
xlabel('Time');ylabel('Amplitude')
subplot(515)
plot(tb, dpsk(1:10*30),'g','linewidth',1.5)
title('DPSK Modulation');grid on
axis([0 10 -0.3 0.3])
xlabel('Time');ylabel('Amplitude')

%AWGN
for snr=0:20
    s=[];
    qp=[];
    askn=awgn(ask,snr);
    pskn=awgn(psk,snr);
    fskn=awgn(fsk,snr);
    dpskn=awgn(dpsk,snr);
    qpskn=awgn(qpsk,snr);

    %DETECTION
    A=[];F=[];P=[];D=[];Q=[];
    for i=1:n
        %ASK Detection
        if sum(sa1.*askn(1+30*(i-1):30*i))>0.5
            A=[A 1];
        else
            A=[A 0];
        end
        %FSK Detection
        if sum(sf1.*fskn(1+30*(i-1):30*i))>0.5
            F=[F 1];
        else
            F=[F 0];
        end
        %PSK Detection
        if sum(sp1.*pskn(1+30*(i-1):30*i))>0
            P=[P 1];
        else
            P=[P 0];
        end
        
        %DPSK Detection
        s=[s sum(sdp0.*dpskn(1+30*(i-1):30*i))];
        if i>1
            if (s(i-1)>0 && s(i)>0) || (s(i-1)<0 && s(i)<0)
                D=[D 0];
            else
                D=[D 1];
            end
        else
            if s(i)<0
                D=[D 1];
            else
                D=[D 0];
            end
        end
        
        %QPSK Detection
        qp=[qp sum(sq0.*qpskn(1+30*(i-1):30*i))];
        if mod(i,2)==0
            if (qp(i-1)>0 && qp(i)>0)
                Q=[Q 0 0];
            elseif (qp(i-1)>0 && qp(i)<0)
                Q=[Q 1 0];
            elseif (qp(i-1)<0 && qp(i)>0)
                Q=[Q 1 1];
            elseif (qp(i-1)<0 && qp(i)<0)
                Q=[Q 0 1];
            end
        end
            
    end

    %BER
    errA=0;errF=0; errP=0; errD=0; errQ=0;
    for i=1:n
        if A(i)==b(i)
            errA=errA;
        else
            errA=errA+1;
        end
        if F(i)==b(i)
            errF=errF;
        else
            errF=errF+1;
        end
        if P(i)==b(i)
            errP=errP;
        else
            errP=errP+1;
        end
        if D(i)==b(i)
            errD=errD;
        else
            errD=errD+1;
        end
        if Q(i)==b(i)
            errQ=errQ;
        else
            errQ=errQ+1;
        end
    end
    BER_A(snr+1)=errA/n;
    BER_F(snr+1)=errF/n;
    BER_P(snr+1)=errP/n;
    BER_D(snr+1)=errD/n;
    BER_Q(snr+1)=errQ/n;
end

figure(2)
subplot(411)
tb=0:1/30:10-1/30;
plot(tb, askn(1:10*30),'b','linewidth',1.5)
title('Received ASK signal');grid on
subplot(412)
plot(tb, fskn(1:10*30),'r','linewidth',1.5)
title('Received FSK signal');grid on
subplot(413)
plot(tb, pskn(1:10*30),'k','linewidth',1.5)
title('Received PSK signal');grid on
subplot(414)
plot(tb, dpskn(1:10*30),'g','linewidth',1.5)
title('Received DPSK signal');grid on


figure(3)
subplot(411)
tb2=0:10-1;
stairs(tb2, A(1:10),'b','linewidth',1.5)
title('Demodulated ASK signal');grid on
subplot(412)
stairs(tb2, F(1:10),'r','linewidth',1.5)
title('Demodulated FSK signal');grid on
subplot(413)
stairs(tb2, P(1:10),'k','linewidth',1.5)
title('Demodulated PSK signal');grid on
subplot(414)
stairs(tb2, D(1:10),'g','linewidth',1.5)
title('Demodulated DPSK signal');grid on

figure(4)
subplot(411)
stairs(0:9,b(1:10),'linewidth',1.5)
axis([0 10 -0.5 1.5])
title('Message Bits');grid on
subplot(412)
tb=0:1/30:10-1/30;
plot(tb, qpsk(1:10*30),'m','linewidth',1.5)
title('QPSK Modulation');grid on
axis([0 10 -0.3 0.3])
subplot(413)
plot(tb, qpskn(1:10*30),'m','linewidth',1.5)
title('Received QPSK signal');grid on
subplot(414)
stairs(0:9, Q(1:10),'m','linewidth',1.5)
title('Demodulated QPSK signal');grid on

figure(5)
semilogy(0:20,BER_A, 'b','linewidth',2)
title('BER Vs SNR')
grid on;
hold on;
semilogy(0:20,BER_F,'r','linewidth',2)
semilogy(0:20,BER_P, 'k','linewidth',2)
semilogy(0:20,BER_D, 'g','linewidth',2)
semilogy(0:20,BER_Q, 'm','linewidth',2)
xlabel('Eo/No(dB)')
ylabel('BER')
hold off;
legend('ASK','FSK','PSK','DPSK','QPSK');