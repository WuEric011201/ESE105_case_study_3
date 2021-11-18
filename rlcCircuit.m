% Script to simulate RLC circuit

%% Initial constants
h = 1/(192*10^3); % h is 1/192k hz

kmax = 2880; % number of time steps
% components of circuit
R = 100;
L = 100*10^-3;
C = 1*10^-6;

Vin = [0; ones(kmax, 1)];

Vc = 0;
I = 0;

% Matricies derived
x = [Vc, I; zeros(kmax, 2)];
A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];

%% Simulating as time goes on
for k=2:kmax
%     xk=A*(x(k-1, :)')+B*Vin(k-1, :);
%     x(k, :) = xk';
    x(k, :) = A*(x(k-1, :)')+B*Vin(k-1, :);
end

%% Plotting
t = 0:h:kmax*h; % Make time vector

figure;
hold on;
plot(t, x(:, 2)*R);
plot(t, Vin(:, 1));