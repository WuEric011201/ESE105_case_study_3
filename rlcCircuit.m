%% Question 3 Part 1
clear;
clc;
close all;
% Script to simulate RLC circuit

%% Initial constants
h = 1/(192*10^3); % Initialize h

kmax = 2880; % number of time steps

% Different responses of circuit
% Same amplitude
R_same = 50;
L_same = 100*10^-3;
C_same = 0.1*10^-6;

% Components for other 2 circuits
% Red
R_decay = 200;
L_decay = 100*10^-3;
C_decay = 0.1*10^-6;

% Purple
R_growth = 30;
L_growth = 100*10^-3;
C_growth = 0.1*10^-6;


Vin = [0; ones(kmax, 1)];

Vc = 0;
I = 0;

% Matricies derived
x_same = [Vc, I; zeros(kmax, 2)];
A1 = [1, h/C_same;
    -h/L_same, 1-h*R_same/L_same];
B1 = [0; h/L_same];

x_decay = [Vc, I; zeros(kmax, 2)];
A2 = [1, h/C_decay;
    -h/L_decay, 1-h*R_decay/L_decay];
B2 = [0; h/L_decay];

x_growth = [Vc, I; zeros(kmax, 2)];
A3 = [1, h/C_growth;
    -h/L_growth, 1-h*R_growth/L_growth];
B3 = [0; h/L_growth];

%% Simulating as time goes on
for k=2:kmax
    x_same(k, :) = A1*(x_same(k-1, :)')+B1*Vin(k-1, :);
    x_decay(k, :) = A2*(x_decay(k-1, :)')+B2*Vin(k-1, :);
    x_growth(k, :) = A3*(x_growth(k-1, :)')+B3*Vin(k-1, :);
end

%% Plotting
t = 0:h:kmax*h; % Make time vector

figure;
hold on;
plot(t, Vin(:, 1), 'b', 'linewidth',2);
plot(t, x_same(:, 2)*R_same, 'g', 'linewidth',2);
plot(t, x_decay(:, 2)*R_decay, 'r', 'linewidth',2);
plot(t, x_growth(:, 2)*R_growth, 'm', 'linewidth',2);
legend("Voltage in", "Ring quick decay", "Tuned Oscillation", "Unstable Oscillation");
ylabel("Voltage (V)");
xlabel("Time (s)");
title("Different oscillations");


%% Questions
% C changes how fast the oscillations dampen, and the decay. An increase in
% C causes the oscillations to dampen much quicker, and a smaller C causes 
% oscillations to dampen slower. It also affects the amplitude of the
% graph.

% Changing R only changes how fast the oscillation dampens. A larger R
% makes the oscillations dampen faster, and a smaller R causes them to
% dampen slower.

% Changing L changes the period of the oscillation. A larger L value makes
% the period larger.

%% Sounds
soundsc(x_same); % Green
% Sounds like an even, low note
pause(1);
soundsc(x_decay); % Red
% Sounds like a quick, low note
pause(1);
soundsc(x_growth); % Purple
% Sounds like a note that is increasing in volume

