function [a,b]=underdamp(wn,z)
a=wn*sqrt(1-(z^2));
b=acos(z);
end