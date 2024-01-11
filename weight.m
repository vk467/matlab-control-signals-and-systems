function [out]=weight(in)
 out=0;
 for loop=1:length(in)
 if(in(loop)==1)
 out=out+1;
 end
 end
end