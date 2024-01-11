function descrambled = Unscram(scrambled, Polynomial)

n=length(scrambled);
degree = length(Polynomial)-1;
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
%     disp(stmt);
    shift_register = circshift(shift_register, 1);
    descrambled(i)=x2;
    shift_register(1) = scrambled(i);
end
