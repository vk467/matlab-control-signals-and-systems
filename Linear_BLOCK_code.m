clc;
clear all;
n=input("Enter n value: ");
k=input("Enter k value: ");
pol = cyclpoly(n,k);
[parmat,genmat,f] = cyclgen(n,pol);
disp('Generator Polynomial');
g = [genmat(:,n-k+1:n) genmat(:,1:n-k)]
c = zeros(1,n);
d=input("Enter dataword: ");
for i=1:n
    for j=1:k
        if j==1
            p=and(d(j),g(j,i));
        else
            temp=and(d(j),g(j,i));
            p=xor(p,temp);
        end
    end
    c(i)=p;
end
disp("Codeword:");
disp(c);
R=input("Enter received word: ");

%decoder
disp('Parity check matrix: ');
pa=[parmat(:,n-k+1:n) parmat(:,1:n-k)]
s=zeros(1,n-k);
for i=1:n-k
    for j=1:n
        if j==1
            p=and(R(j),pa(i,j));
        else
            temp=and(R(j),pa(i,j));
            p=xor(p,temp);
        end
        
    end
    s(i)=p;
end
disp("Syndrome:");
disp(s);
error=0;
for t=1:n
    m = pa(:,t);
    if isequal(s.',m)
        error=1;
        break
    end
end
if error==1
    disp(['Error in bit:' num2str(t)]);
    if R(t)==0
        R(t)=1;
    else
        R(t)=0;
    end
else
    disp('No Error');
end
Rx = R(1,1:k);
disp("Decoded word:");
disp(Rx);

% clc
% clear all
% close all
% dataword=input("Enter 11 Bit Dataword:");
% disp('Generator matrix: ');
% generator=[ 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
%             0 1 0 0 0 0 0 0 0 0 0 1 0 1 0;
%             0 0 1 0 0 0 0 0 0 0 0 0 1 1 0;
%             0 0 0 1 0 0 0 0 0 0 0 1 1 1 0;
%             0 0 0 0 1 0 0 0 0 0 0 1 0 0 1;
%             0 0 0 0 0 1 0 0 0 0 0 0 1 0 1;
%             0 0 0 0 0 0 1 0 0 0 0 1 1 0 1;
%             0 0 0 0 0 0 0 1 0 0 0 0 0 1 1;
%             0 0 0 0 0 0 0 0 1 0 0 1 0 1 1;
%             0 0 0 0 0 0 0 0 0 1 0 0 1 1 1;
%             0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]
% for i=1:15
%     for j=1:11
%         if j==1
%             p=and(dataword(j),generator(j,i));
%         else
%             k=and(dataword(j),generator(j,i));
%             p=xor(p,k);
%         end
%     end
%     codeword(i)=p;
% end
% disp("codeword sent:");
% disp(codeword);
% Receivedword=input("Enter Received word: ");
% %decoder
% disp('Parity check matrix: ');
% parity=[1 1 0 0;
%     1 0 1 0;
%     0 1 1 0;
%     1 1 1 0;
%     1 0 0 1;
%     0 1 0 1;
%     1 1 0 1;
%     0 0 1 1;
%     1 0 1 1;
%     0 1 1 1;
%     1 1 1 1;
%     1 0 0 0;
%     0 1 0 0;
%     0 0 1 0;
%     0 0 0 1;
%     ]
% for i=1:4
%     for j=1:15
%         if j==1
%             p=and(Receivedword(j),parity(j,i));
%         else
%             k=and(Receivedword(j),parity(j,i));
%             p=xor(p,k);
%         end
%         
%     end
%     syndrome(i)=p;
% end
% disp("Syndrome is:");
% disp(syndrome);
% for t=1:15
%     if syndrome==parity(t,1:4)
%         break
%     end
% end
% if Receivedword(t)==0
%     Receivedword(t)=1;
% else
%     Receivedword(t)=0;
% end
% disp("Decoded word:");
% disp(Receivedword(1:11));