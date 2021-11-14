% Script to simulate RC circuit
%% Initial values

R = 1000;
C = 1*10^-6;
Vin = 1;
h = 1*10^-6;
Vc = [0, 0];

hbad = 0.0001;
Vcbad = [0, 0];
%% Simulate charging

% V is [time, voltage]

% for good h
while(abs(Vin-Vc(end, 2)) > .05)
    % Make Vc a horizontal vector. Next term is added to end
    Vc = [Vc; Vc(end, 1)+h, (1-h/(R*C))*Vc(end, 2)+ h/(R*C)*Vin];
end

% bad h
while(abs(Vin-Vcbad(end, 2)) > .05)
    % Make Vc a horizontal vector. Next term is added to end
    Vcbad = [Vcbad; Vcbad(end, 1)+hbad, (1-hbad/(R*C))*Vcbad(end, 2)+ hbad/(R*C)*Vin];
end


%% Plotting Vc
t = Vc(end, 1);

figure;
hold on;
plot([0 t], [Vin Vin]);
plot(Vc(1:end, 1), Vc(1:end, 2));
title("Voltage vs Time");
ylabel("Voltage");
xlabel("Time");
legend("Voltage in", "Voltage capacitor");

figure;
hold on;
plot(Vc(1:end, 1), Vc(1:end, 2));
plot(Vcbad(1:end, 1), Vcbad(1:end, 2));
fplot(@(t) 1-exp(-t/(R*C)), [0 t]);
