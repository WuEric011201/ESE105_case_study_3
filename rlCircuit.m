% Script to plot RL circuit

%% Initial values
R = 100;
L = 100*10^-3;
Vin = 1;
i = [0, 0]; % i has t in first column, current in second
h = 1*10^-6;

%% Calculating i and v
while( abs(i(end, 2)-.01) > 0.0001)
    i = [i; [i(end, 1)+h, (1-h*R/L)*i(end, 2)+h/L*Vin]];
    
end

Vl = [i(:, 1), Vin-R*i(:, 2)];

%% Plotting
t = Vl(end, 1);

figure;
hold on;
plot([0 t], [Vin Vin]);
plot(Vl(1:end, 1), Vl(1:end, 2));
title("Voltage vs Time");
ylabel("Voltage");
xlabel("Time");
legend("Voltage in", "Voltage inductor");

%% Questions
% The steady state voltage of a capaciter is the input voltage. However,
% for an inducter, it is 0. The capaciter also starts off at 0, and curves
% concave down to the input voltage. The inducter starts off at the input
% voltage, and curves concave up towards 0.