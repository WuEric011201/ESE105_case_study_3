<<<<<<< HEAD
%% Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
%
% *Name: FILL IN HERE*
%
% function mySensorCircuit(Vin,h) receives a time-series voltage sequence
% sampled with interval h, and returns the output voltage sequence produced
% by a circuit
%
% inputs:
% Vin - time-series vector representing the voltage input to a circuit
% h - scalar representing the sampling interval of the time series in
% seconds
%
% outputs:
% Vout - time-series vector representing the output voltage of a circuit

function Vout = mySensorCircuit(Vin,h)
Vout = [0 0; zeros(length(Vin)-1, 2)];
% R=2;
% L=1600*10^-3;
% C=9/4*10^-6;

R=1;
L=1.6;
C=1.1218449233*2*10^-6;

A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];
for time = 1:length(Vout)
    if time> 1
        Vout(time, :) = A*(Vout(time-1, :)')+B*Vin(time-1, :);
    end
end
Vout = Vout * R;
=======
function Vout = mySensorCircuit(Vin,h)
%% MYSENSORCIRCUIT Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
% 
% *Name: FILL IN HERE*
% 
% function mySensorCircuit(Vin,h) receives a time-series voltage sequence sampled 
% with interval h, and returns the output voltage sequence produced by a circuit
% 
% inputs: Vin - time-series vector representing the voltage input to a circuit 
% h - scalar representing the sampling interval of the time series in seconds
% 
% outputs: Vout - time-series vector representing the output voltage of a circuit
Vout = [0 0; zeros(length(Vin)-1, 2)];
% R=2;
% L=1600*10^-3;
% C=9/4*10^-6;
R=1;
L=1.6;
C=1.1218449233*2*10^-6;
A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];
for time = 1:length(Vout)
    if time> 1
        Vout(time, :) = A*(Vout(time-1, :)')+B*Vin(time-1, :);
    end
end
Vout = Vout * R;
>>>>>>> 06d09a3a58865065213e6e1cbd34e230721acfcd
end