clc;
clear all; 
close all;
m=input('enter constraint length:'); %constraint length
p=2^(m-1); %number of states
n=input('enter number of output bits to be generated for each input bit (1/rate):');
g=zeros(n,m);
for i=1:n
     fprintf('enter generator polynomial for %d th output(highest degree coefficient to left):',i);
     g(i,:)=input('');
end
mat=inf*ones(p);
tran=inf*ones(p);
for i=1:p
 for j=0:1
     t=[dec2bin(i-1,m-1)-48 j];
     for k=1:n
        u(k)=mod(sum(t.*g(k,:)),2);
     end
     u=binarytodecimal(u);
     t=binarytodecimal(t(2:m));
     mat(i,t+1)=u; %outputs
     tran(i,t+1)=j; %excitation input
 end
end
r=input('enter received bit vector:'); %received bits
s=length(r)/n;
cost=inf*ones(s,p);
from=inf*ones(s,p);
temp=inf*ones(p,p,s);
for k=1:s
 for i=1:p
     for j=1:p
         if(mat(i,j)<inf)
            temp(i,j,k)=weight(bitxor(dec2bin(mat(i,j),n)-48,r(1,n*(k-1)+1:n*k)));
         else
            temp(i,j,k)=inf;
         end
     end
 end
end
for j=1:p
 if(tran(1,j)<inf)
     cost(1,j)=temp(1,j,1);
     from(1,j)=1; %initial state
 end
end
for k=2:s
 for j=1:p
     z=0;
     for i=1:p
         if(temp(i,j,k)<inf)
         z=z+1;
         a(z)=i;
         end
     end
     for l=1:z
         if(cost(k,j)>(temp(a(l),j,k)+cost(k-1,a(l))))
         cost(k,j)=temp(a(l),j,k)+cost(k-1,a(l));
         from(k,j)=a(l);
         end
     end
 end
end
mincost=inf;
for j=1:p
 if(mincost>cost(s,j))
     mincost=cost(s,j);
     path(s+1)=j;
     path(s)=from(s,j);
 end
end
for k=s-1:-1:1
 path(k)=from(k,path(k+1));
end
for k=1:s
 decoded(k)=tran(path(k),path(k+1));
end
disp('decoded output:');
disp(decoded);