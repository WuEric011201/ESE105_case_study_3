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
% Make graph function of time for theoretical charging
fplot(@(t) 1-exp(-t/(R*C)), [0 t]);
title("Voltage across capaciter vs time");
xlabel("Time");
ylabel("Voltage");
legend("h voltage", "inaccurate h voltage", "Theoretical voltage");

%% Questions
% As h increases, the V(t) curve becomes less and less like how the real
% capaciter acts. Our inaccurate h is visably above and less curved than
% our more accurate h value. Compared to the real curve, however, the
% accurate h produces a curve that is close, but if you zoom in really
% really close, there is a difference between the descrete charging curve
% and the real one, a difference of scale close to 0.0002, which is
% relatively low.

% RC determines how long it takes the capaciter to charge. A larger RC
% term causes the capaciter to take a longer time to charge, while a
% smaller RC makes it take less time. This makes sense in terms of our
% equations too, as h/RC*Vin is added to Vc with every increment, so a
% smaller RC means a larger fraction of Vin is added to Vc. (1-(RC) is also
% multiplied by Vc every increment, but Vin is alrger than Vc, so that term
% has more of an impact on the change in Vc)