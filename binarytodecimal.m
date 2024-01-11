function [out]=binarytodecimal(in)
 in=fliplr(in);
 out=0;
 for loop=1:length(in)
 out=out+in(loop)*2^(loop-1);
 end
end