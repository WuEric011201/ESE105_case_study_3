% Script to simulate RLC circuit

%% Initial constants
h = 1/(192*10^3); % h is 1/192k hz

kmax = 2880; % number of time steps

% components of circuit
% Green
R1 = 50;
L1 = 100*10^-3;
C1 = 0.1*10^-6;

% Components for other 2 circuits
% Red
R2 = 200;
L2 = 100*10^-3;
C2 = 0.1*10^-6;

% Purple
R3 = 30;
L3 = 100*10^-3;
C3 = 0.1*10^-6;


Vin = [0; ones(kmax, 1)];

Vc = 0;
I = 0;

% Matricies derived
x1 = [Vc, I; zeros(kmax, 2)];
A1 = [1, h/C1;
    -h/L1, 1-h*R1/L1];
B1 = [0; h/L1];

x2 = [Vc, I; zeros(kmax, 2)];
A2 = [1, h/C2;
    -h/L2, 1-h*R2/L2];
B2 = [0; h/L2];

x3 = [Vc, I; zeros(kmax, 2)];
A3 = [1, h/C3;
    -h/L3, 1-h*R3/L3];
B3 = [0; h/L3];

%% Simulating as time goes on
for k=2:kmax
    x1(k, :) = A1*(x1(k-1, :)')+B1*Vin(k-1, :);
    x2(k, :) = A2*(x2(k-1, :)')+B2*Vin(k-1, :);
    x3(k, :) = A3*(x3(k-1, :)')+B3*Vin(k-1, :);
end

%% Plotting
t = 0:h:kmax*h; % Make time vector

figure;
hold on;
plot(t, Vin(:, 1), 'b', 'linewidth',2);
plot(t, x1(:, 2)*R1, 'g', 'linewidth',2);
plot(t, x2(:, 2)*R2, 'r', 'linewidth',2);
plot(t, x3(:, 2)*R3, 'm', 'linewidth',2);
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