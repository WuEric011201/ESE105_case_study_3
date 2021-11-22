clear;
clc;
close all;

h = 1/(192*10^3); % Initialize h

kmax = 2880; % number of time steps

% Different responses of circuit
% Same amplitude
R_same = 50;
L_same = 100*10^-3;
C_same = 0.1*10^-6;

% Components for other 2 circuits
% Red
R_decay = 50;
L_decay = 150*10^-3;
C_decay = 0.1*10^-6;

% Purple
R_growth = 50;
L_growth = 50*10^-3;
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
legend("Voltage in", "Original", "Larger Inductince", "Smaller Inductance");
ylabel("Voltage (V)");
xlabel("Time (s)");
title("Different oscillations");
