%% Clean up the environment
clc;
clearvars
close all

%% Part 1: RC Circuit
% Set constants and initial conditions
R = 1e3; % Resistance in Ohms
C = 1e-6; % Capacitance in Farads
h = 0.00001; % Time step in seconds (you can choose a different value here if you want)
vC0 = 0;
vR0 = 0;

% Look at the recitation slides for help on why these equations are entered
% the way they are!
vin = ones(1,1000); % This is the input
v = zeros(2,1000); % These are our states
v(:,1) = [vR0; vC0]; % Our states are vR and vC, so they can be put into a matrix

% Simulate the system forward 100 steps in time
for k=1:999
    v(:,k+1) = [0 -(1-(h/(R*C))); 0 (1-(h/(R*C)))]*v(:,k) + [h/(R*C)-1; h/(R*C)]*vin(k);
end

figure;
plot(h.*(1:k+1),v(2,:));
xlabel('Time (s)');
ylabel('v_C (V)');
title('Voltage across Capacitor, h = 1e-05');

% Now run the simulation with different time steps
t_step = [1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1];
for i=1:7
    h = t_step(i);
    % Reset initial conditions
    v = zeros(2,1000);
    v(:,1) = [vR0; vC0];
    
    for k=1:999
        v(:,k+1) = [0 -(1-(h/(R*C))); 0 (1-(h/(R*C)))]*v(:,k) + [h/(R*C)-1; h/(R*C)]*vin(k);
    end
    figure;
    plot(h.*(1:k+1),v(2,:));
    xlabel('Time (s)');
    ylabel('v_C (V)');
    title(['Voltage across Capacitor, h = ',num2str(h)]);
end

% Plot "real" function of t
t = 0:1e-6:0.1;
figure;
plot(t,1-exp(-t/(R*C)));
xlabel('Time (s)');
ylabel('v_C (V)');
title('Voltage across Capacitor, "Continuous"');
    