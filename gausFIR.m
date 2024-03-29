function y = gausFIR(x)
%GAUSFIR Filters input x and returns output y.

% MATLAB Code
% Generated by MATLAB(R) 9.7 and DSP System Toolbox 9.9.
% Generated on: 10-Apr-2021 09:57:09

%#codegen

% To generate C/C++ code from this function use the codegen command. Type
% 'help codegen' for more information.

persistent Hd;

if isempty(Hd)
    
    % The following code was used to design the filter coefficients:
    % % FIR Window Lowpass filter designed using the FIR1 function.
    %
    % % All frequency values are in Hz.
    % Fs = 48000;  % Sampling Frequency
    %
    % N     = 55;       % Order
    % Fc    = 10800;    % Cutoff Frequency
    % flag  = 'scale';  % Sampling Flag
    % Alpha = 2.5;      % Window Parameter
    %
    % % Create the window vector for the design algorithm.
    % win = gausswin(N+1, Alpha);
    %
    % % Calculate the coefficients using the FIR1 function.
    % b  = fir1(N, Fc/(Fs/2), 'low', win, flag);
    
    Hd = dsp.FIRFilter( ...
        'Numerator', [0.000469803538136973 -0.000153986162701468 ...
        -0.00084718988020486 -8.53236197286571e-05 0.00134430175371363 ...
        0.000668254816773684 -0.00186885202353872 -0.00177587161593016 ...
        0.00220249548834691 0.00356610628052895 -0.00196339475586123 ...
        -0.00608933919742409 0.000596982450873019 0.00917865969421241 ...
        0.002591722843039 -0.0123339488280699 -0.00837248923707028 ...
        0.0146152035850848 0.01754537557158 -0.0145147590365922 ...
        -0.0310750203409133 0.00959961266409736 0.0509112235515468 ...
        0.00510380313564259 -0.0840588498811222 -0.0474774358703629 ...
        0.179242318411067 0.412980596664877 0.412980596664877 0.179242318411067 ...
        -0.0474774358703629 -0.0840588498811222 0.00510380313564259 ...
        0.0509112235515468 0.00959961266409736 -0.0310750203409133 ...
        -0.0145147590365922 0.01754537557158 0.0146152035850848 ...
        -0.00837248923707028 -0.0123339488280699 0.002591722843039 ...
        0.00917865969421241 0.000596982450873019 -0.00608933919742409 ...
        -0.00196339475586123 0.00356610628052895 0.00220249548834691 ...
        -0.00177587161593016 -0.00186885202353872 0.000668254816773684 ...
        0.00134430175371363 -8.53236197286571e-05 -0.00084718988020486 ...
        -0.000153986162701468 0.000469803538136973]);
end

y = step(Hd,double(x));


% [EOF]
