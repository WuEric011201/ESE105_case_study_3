%% Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
%
% *Name: FILL IN HERE*
%
% function myResonatorCircuit(Vin,h) receives a time-series voltage sequence
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

% We are basic so we will do A4.
% Want low R, low C, high L

% 440hz, L*C = 1.308*10^-7
function Vout = myResonatorCircuit(Vin,h)
R = 4;
L = 100*10^-3;
C = 1.308*10^-6;

A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];

kmax = size(Vin, 1);

Vc = 0;
I = 0;

x=[Vc, I; zeros(kmax, 2)];

for k=2: kmax
    x(k, :) = A*(x(k-1, :)')+B*Vin(k-1, :);
end
Vout = x(:, 2)*R;

figure;
plot(1:h:kmax*h+1, Vout);
title("Sound wave");
ylabel("Voltage across resistor(V)");
xlabel("Time(s)");
% Vout = Vin;
end