clc;
clear all;
k=input('Enter Input bits length: ');
data=input('Enter Data word: ');
d=length(data);

g=input("Enter Transfer Function (n x N): ");
s=size(g);
n=s(1);
N=s(2);

shift_register=zeros(1,N);
output=[];

for i=1:d
    for j=N:-1:1
        if j==1
            shift_register(j)=data(i);
        else
            shift_register(j)=shift_register(j-1);
        end
    end
%     stmt = ['Shift Register: ' num2str(shift_register)] ;
    disp('shift_register');
    disp(shift_register);
    temp=zeros(1,n);
    for a=1:n
        for j=1:N
            temp(a)=xor(temp(a),and(shift_register(j),g(a,j)));
        end
    end
    output=[output temp];
end
disp("Transmitter word:")
disp(output)


% % %Viterbi Decoder
% % Rx = input('Enter Received word: ');
% n=2;
% N=3;
% Rx=[0 0 0 0 0 1 1 0 1 1];
% g=[1 1 1;1 0 1];
% cl = n*N;
% 
% states= de2bi(0:2^(N-1)-1,(N-1));
% 
% op_for_zero = zeros(2^n, n); 
% op_for_one = zeros(2^n, n);
% 
% for i=1:size(states,1)
%     temp=zeros(1,n);
%     sr=[1 states(i,:)];
%     for a=1:n
%         for j=1:N
%             temp(a)=xor(temp(a),and(sr(j),g(a,j)));
%         end
%     end
%     op_for_one(i,:)= temp;
%     temp=zeros(1,n);
%     sr=[0 states(i,:)];
%     for a=1:n
%         for j=1:N
%             temp(a)=xor(temp(a),and(sr(j),g(a,j)));
%         end
%     end
%     op_for_zero(i,:)= temp;
% end
% 
% rx1=Rx(1,1:6);
% path1 = [ 0 0; 1 0];
% path2 = [ 1 0; 1 1]; 
% path3 = [ 0 0; 1 0]; 
% path4 = [ 0 1; 1 1];
% for i=1:size(states,1)
%     paths=[];
%     cs=[0 0];
%     for x=1:2
%         for y=1:2
%             for z=1:2
%                 paths=[paths ; path
%             end
%         end
%     end
% end
% xo=xor(rx1,temp);
% hamming=sum(xo(:)==1);
