%   The working of the Advanced Delta Modulator is similar to the regular
%   Delta Modulator. The only difference is that the amplitude step 
%   size is variable and it keeps getting doubled if the previous output/s
%   don't seem to 'catch up' with the input signal. This problem is
%   referred to as 'Slope overload' in textbooks.

function [ADMout] = adeltamod(sig_in, Delta, td, ts)
%   Usage
%       ADMout = adeltamod(sig_in, Delta, fs);
%   Delta -- min. step size. This will be multiplied 2nX if required
%   sig_in -- the signal input, should be a vector
%   td -- the original sampling period of the input signal, sig_in
%   ts -- the required sampling period for ADM output. Note that it
%           should be an integral multiple of the input signal's period.
%           If not, it will be rounded up to the nearest integer.
%   Function output: ADMout


    if (round(ts/td) >= 2)
        Nfac = round(ts/td);    %Nearest integer
        xsig = downsample(sig_in,Nfac);
        Lxsig = length(xsig);
        Lsig_in = length(sig_in);
        
        ADMout = zeros(Lsig_in);    %Initialising output
        
        cnt1 = 0;   %Counters for no. of previous consecutively increasing 
        cnt2 = 0;   %steps
        sum = 0;

        for i=1:Lxsig
            
            if (xsig(i) == sum)

                % do nothing
                
            elseif (xsig(i) > sum)

                if (cnt1 < 2)
                    sum = sum + Delta;  %Step up by Delta, same as in DM
                elseif (cnt1 == 2)
                    sum = sum + 2*Delta;    %Double the step size after
                                            %first two increase
                elseif (cnt1 == 3)
                    sum = sum + 4*Delta;    %Double step size
                else
                    sum = sum + 8*Delta;    %Still double and then stop
                                            %doubling thereon
                end

                if (sum < xsig(i))
                    cnt1 = cnt1 + 1;
                else
                    cnt1 = 0;
                end

            else

                if (cnt2 < 2)
                    sum = sum - Delta;
                elseif (cnt2 == 2)
                    sum = sum - 2*Delta;
                elseif (cnt2 == 3)
                    sum = sum - 4*Delta;
                else
                    sum = sum - 8*Delta;
                end

                if (sum > xsig(i))
                    cnt2 = cnt2 + 1;
                else
                    cnt2 = 0;
                end

            end

            ADMout(((i-1)*Nfac + 1):(i*Nfac)) = sum;
        end
    end
end