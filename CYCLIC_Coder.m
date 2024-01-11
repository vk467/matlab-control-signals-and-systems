% clc;
% clear all;
% n=7;
% k=4;
% g=input('Enter Generator Polynomial: '); 
% data=input('Enter Data: ');
% sr=n-k;
% shift_reg=zeros(1,sr);
% cc=zeros(1,n);
% df=flip(data);
% for i=1:k
%     t1=xor(shift_reg(sr),df(i));
%     for j=sr:-1:1
%         if j>1
%             if g(j)==0
%                 shift_reg(j)=xor(shift_reg(j-1),0);
%             else
%                 shift_reg(j)=xor(shift_reg(j-1),t1);
%             end
%         else
%             shift_reg(1)=t1;
%         end
%     end
%     disp('Shift Register');
%     disp(shift_reg);
% end
% 
% for i=1:n
%     if i<=sr
%         cc(sr-i+1)=shift_reg(sr);
%         shift_reg=circshift(shift_reg,1);
%     else
%         cc(i)=data(i-sr);
%     end
% end
% 
% disp('Cyclic Codeword: ');
% disp(cc);
% 
% rx=input('Enter Received word: ');
% rxf=flip(rx);
% syndrome=zeros(1,n-k);
% for i=1:n
%     t2=syndrome(sr);
%     for j=sr:-1:1
%         if j>1
%             if g(j)==0
%                 syndrome(j)=xor(syndrome(j-1),0);
%             else
%                 syndrome(j)=xor(syndrome(j-1),t2);
%             end
%         else
%             syndrome(1)=xor(t2,rxf(i));
%         end
%     end
%     disp('Syndrome Register');
%     disp(syndrome);
% end 
% 
% if syndrome==zeros(1,sr)
%     disp('No Error in Received word');
% else
%     disp('Error found in Received word');
% end

% clc;
% clear all;
% n=7;
% k=4;
% g=input('Enter Generator Polynomial: '); 
% data=input('Enter Data: ');
% sr=n-k;
% shift_reg=zeros(1,sr);
% cc=zeros(1,n);
% 
% for i=1:k
%     t=[];
%     for j=1:k
%         t=[t data(i)*g(j)];
%     end
%     disp(t);
% end
% 
% disp('Non -systematic Cyclic Codeword: ');
% disp(cc);