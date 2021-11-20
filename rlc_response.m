clc; 
clear;
close all;
%% Question 3 Part 2
% Initialize variables
h = 1/(192*10^3); % Initialize h
steps = 4000; % Longer j to have it more stable
R = 100;
L = 100*10^-3;
C = 0.1*10^-6;

A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];
Vc_initial_initial = 0; % Initial value of 0s
I_initial = 0;
% Populate the containers
Vin = zeros(steps+1, 1);
x = [Vc_initial_initial , I_initial ; zeros(steps, 2)];
Vin(1, 1) = sin(2*pi*h);
band = zeros(10000-10, 1);
for freq = 10: 1: 10000 
    for j = 2:steps
        time = h*j;
        Vin(j, 1) = sin(2 * pi * freq * time);
        x(j, :) = A*(x(j-1, :)')+B*Vin(j-1, :);
    end
    vout = x(:, 2) * R;
    band(freq-9, 1) = norm(vout)/norm(Vin);
end

%% Graphing the results

figure;
hold on;
plot(band);
title("Band pass");
legend(" ");

%% For various frequencies 𝑓, do the output signals “look the same” as the input signals?
frequencies = [100, 1550, 5000, 10000];
kmax = 2880;
Vin1 = [ sin(2*pi*frequencies(1)*h); zeros(kmax, 1)];
xf1 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin1(time, :) = sin(2*pi*frequencies(1)*steps);
    xf1(time, :) = A*(xf1(time-1, :)')+B*Vin1(time-1, :);
end

Vin2 = [ sin(2*pi*frequencies(2)*h); zeros(kmax, 1)];
xf2 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin2(time, :) = sin(2*pi*frequencies(2)*steps);
    xf2(time, :) = A*(xf2(time-1, :)')+B*Vin2(time-1, :);
end

Vin3 = [ sin(2*pi*frequencies(3)*h); zeros(kmax, 1)];
xf3 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin3(time, :) = sin(2*pi*frequencies(3)*steps);
    xf3(time, :) = A*(xf3(time-1, :)')+B*Vin3(time-1, :);
end

Vin4 = [ sin(2*pi*frequencies(1)*h); zeros(kmax, 1)];
xf4 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin4(time, :) = sin(2*pi*frequencies(4)*steps);
    xf4(time, :) = A*(xf4(time-1, :)')+B*Vin4(time-1, :);
end


figure;
hold on;
plot(xf1(:, 2)*R);
plot(Vin1);

figure;
hold on;
plot(xf2(:, 2)*R);
plot(Vin2);

figure;
hold on;
plot(xf3(:, 2)*R);
plot(Vin3);

figure;
hold on;
plot(xf4(:, 2)*R);
plot(Vin4);
% How are the shapes and/or amplitudes different?
% The filter is a bandpass filter. Frequencies at a range around 1500 are
% allowed to pass, while all other frequencies have their amplitudes cut
% significantly

%% For what frequencies 𝑓 is the output approximately the same amplitude as the input? 
%And, for what frequencies is it much bigger? Or much smaller? 
%Would you call this circuit a “lowpass,” “bandpass,” or “highpass” filter? 
%


%% Interpret what you hear in terms of what you see in the voltage vs. time graphs.
%What do small or large amplitudes sound like? What do small, medium, and large frequencies sound like?
z = 1: 2000;
sintest = sin(0.5*z) ;
figure;
plot(sintest);
% soundsc(sintest); % this is working

% TODO parts I cannot figure out
playSound(sintest,  1900);
playSound(xf1(:, 2)*R,  20000);
playSound(xf2(:, 2)*R,  20000);
playSound(xf3(:, 2)*R,  20000);
playSound(xf4(:, 2)*R,  20000);