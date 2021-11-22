%% Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
%
% *Name: Tong Wu*
%
% function myFilterCircuit(Vin,h) receives a time-series voltage sequence
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
function Vout = myFilterCircuit(Vin,h)

R = 20000; % how steep it is 
L = 7000*10^-3; % how sharp it is 
C = 0.007*10^-6;% moving the band peak from left to right 

A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];
I_initial = 0;
% Populate the containers
Vout = [Vin(1,1) , I_initial ; zeros(length(Vin)-1, 2)];

for j = 2: length(Vin)
        Vout(j, :) = A*(Vout(j-1, :)')+B*Vin(j-1, :);
end
    Vout = Vout(:, 2) * R;
end