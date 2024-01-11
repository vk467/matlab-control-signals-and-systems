clc;
clear all;
close all;
data = input('Enter Data: ');
Polynomial = input('Enter Polynomial: ');
n=length(data);
degree = length(Polynomial)-1;
shift_register = zeros(1,degree);
scrambled = zeros(1,n);

for i=1:n
    x = 0;
    for j=1:degree
        if Polynomial(j)==1
            x = xor(x,shift_register(degree-j+1));
        end
    end
    x2 = xor(data(i),x);
    stmt = ['Shift Register: ' num2str(shift_register)] ;
    disp(stmt);
    shift_register = circshift(shift_register, 1);
    scrambled(i)=x2;
    shift_register(1) = x2;
end

disp('Scrambled output:');
disp(scrambled);

disp('Descrambler...');
shift_register = zeros(1,degree);
descrambled = zeros(1,n);

for i=1:n
    x = 0;
    for j=1:degree
        if Polynomial(j)==1
            x = xor(x,shift_register(degree-j+1));
        end
    end
    x2 = xor(scrambled(i),x);
    stmt = ['Shift Register: ' num2str(shift_register)] ;
    disp(stmt);
    shift_register = circshift(shift_register, 1);
    descrambled(i)=x2;
    shift_register(1) = scrambled(i);
end

disp('Decrambled output:');
disp(descrambled);

