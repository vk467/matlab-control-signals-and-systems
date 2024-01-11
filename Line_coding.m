clearvars; 
clc;

L = 32; %number of digital samples per data bit
Fs = 8*L; %Sampling frequency
voltageLevel = 5; %peak voltage level in Volts
data = rand(10000,1)>0.5; %random 1s and 0s for data
clk = mod(0:2*numel(data)-1,2).'; %clock samples

ami = 1*data; previousOne = 0; %AMI encoding
for ii=1:numel(data)
    if (ami(ii)==1) && (previousOne==0)
        ami(ii)= voltageLevel;
        previousOne=1;
    end 
    if (ami(ii)==1) && (previousOne==1)
        ami(ii)= -voltageLevel;
        previousOne = 0;
    end    
end

%converting the bits to sequences and mapping to voltage levels
clk_sequence=reshape(repmat(clk,1,L).',1,length(clk)*L);
data_sequence=reshape(repmat(data,1,2*L).',1,length(data)*2*L);
unipolar_nrz_l = voltageLevel*data_sequence;
nrz_encoded = voltageLevel*(2*data_sequence - 1);
unipolar_rz = voltageLevel*and(data_sequence,not(clk_sequence));
ami_sequence = reshape(repmat(ami,1,2*L).',1,length(ami)*2*L);
manchester_encoded = voltageLevel*(2*xor(data_sequence,clk_sequence)-1);

figure; %Plot signals in time domain 
subplot(7,1,1); plot(clk_sequence(1:800)); title('Clock');
subplot(7,1,2); plot(data_sequence(1:800)); title('Data')
subplot(7,1,3); plot(unipolar_nrz_l(1:800)); title('Unipolar non-return-to-zero level')
subplot(7,1,4); plot(nrz_encoded(1:800)); title('Bipolar Non-return-to-zero level')
subplot(7,1,5); plot(unipolar_rz(1:800)); title('Unipolar return-to-zero')
subplot(7,1,6); plot(ami_sequence(1:800)); title('Alternate Mark Inversion (AMI)')
subplot(7,1,7); plot(manchester_encoded(1:800)); title('Manchester Encoded - IEEE 802.3')

figure; %Plot power spectral density
ns = max(size(unipolar_nrz_l));
na = 16;%averaging factor to plot averaged welch spectrum
w = hanning(floor(ns/na));%Hanning window
%Plot Welch power spectrum using Hanning window
[Pxx1,F1] = pwelch(unipolar_nrz_l,w,[],[],1,'onesided');
[Pxx2,F2] = pwelch(nrz_encoded,w,[],[],1,'onesided'); 
[Pxx3,F3] = pwelch(unipolar_rz,w,[],[],1,'onesided'); 
[Pxx4,F4] = pwelch(ami_sequence,w,[],[],1,'onesided'); %
[Pxx5,F5] = pwelch(manchester_encoded,w,[],[],1,'onesided'); 

semilogy(F1,Pxx1,'DisplayName','Unipolar-NRZ-L');hold on;
semilogy(F2,Pxx2,'DisplayName','Bipolar NRZ(L)');
semilogy(F3,Pxx3,'DisplayName','Unipolar-RZ');
semilogy(F4,Pxx4,'DisplayName','AMI'); 
semilogy(F5,Pxx5,'DisplayName','Manchester');
legend();