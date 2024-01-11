    %   Design a 55th-order lowpass filter
    f = [0 0.6 0.6 1];      
    m = [1 1 0 0];          
    b = fir2(55,f,m);       
    freqz(b,1,512) 
