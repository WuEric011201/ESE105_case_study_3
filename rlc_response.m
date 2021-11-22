
%% Question 3 Part 2
clc; 
clear;
close all;
% Initialize variables
h = 1/(192*10^3); % Initialize h
steps = 4000; % Longer j to have it more stable
% R = 100; % how steep it is 
% L = 100*10^-3; %how sharp it is 
% C = 0.1*10^-6;% moving the band peak from left to right 
R = 20000; % how steep it is 
L = 7000*10^-3; % how sharp it is 
C = 0.007*10^-6;% moving the band peak from left to right 

A = [1, h/C;
    -h/L, 1-h*R/L];
B = [0; h/L];
Vc_initial = 0; % Initial value of 0s
I_initial = 0;
% Populate the containers
Vin = zeros(steps+1, 1);
x = [Vc_initial, I_initial ; zeros(steps, 2)];
Vin(1, 1) = sin(2*pi*h);
band = zeros((10000-10)/10, 1);
for freq = 10: 10: 10000 % Increment frequency steps
    for j = 2:steps
        time = h*j;
% Calculte the input voltage and resulting current and voltage
        Vin(j, 1) = sin(2 * pi * freq * time);
        x(j, :) = A*(x(j-1, :)')+B*Vin(j-1, :);
    end
    vout = x(:, 2) * R; % Calculate the output signal
% store how the circuit behaves by comparing input and output
    band(freq/10, 1) = norm(vout)/norm(Vin); 
end

% Graphing the result
f = 10: 10: 10000; % initialize frequency
figure;
hold on;
plot(f, band);
title("Band pass RLC circuit's behaviour under varying frequencies");
xlabel("Frequency (Hz)");
ylabel("Norm of amplitude");

%% For various frequencies 𝑓, do the output signals “look the same” as the input signals?
% Choose four frequencies over a wide range we want to approximate
frequencies = [1000, 1600, 5000, 10000];
kmax = 2880; % Max steps
% Initialize containers
Vin1 = [ sin(2*pi*frequencies(1)*h); zeros(kmax, 1)];
xf1 = [Vc_initial, I_initial ; zeros(kmax, 2)];
% Model how circuit behave over time over different frequencies
for time = 2:kmax+1
    steps = h*time;
    Vin1(time, :) = sin(2*pi*frequencies(1)*steps);
    xf1(time, :) = A*(xf1(time-1, :)')+B*Vin1(time-1, :);
end
% Frequnecy 2
Vin2 = [ sin(2*pi*frequencies(2)*h); zeros(kmax, 1)];
xf2 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin2(time, :) = sin(2*pi*frequencies(2)*steps);
    xf2(time, :) = A*(xf2(time-1, :)')+B*Vin2(time-1, :);
end
% Frequnecy 3
Vin3 = [ sin(2*pi*frequencies(3)*h); zeros(kmax, 1)];
xf3 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin3(time, :) = sin(2*pi*frequencies(3)*steps);
    xf3(time, :) = A*(xf3(time-1, :)')+B*Vin3(time-1, :);
end
% Frequnecy 4
Vin4 = [ sin(2*pi*frequencies(1)*h); zeros(kmax, 1)];
xf4 = [Vc_initial, I_initial ; zeros(kmax, 2)];
for time = 2:kmax+1
    steps = h*time;
    Vin4(time, :) = sin(2*pi*frequencies(4)*steps);
    xf4(time, :) = A*(xf4(time-1, :)')+B*Vin4(time-1, :);
end

% Plot four differenet circuit behavious under different input
figure;
hold on;
plot(xf1(:, 2)*R);
plot(Vin1);
title("Band pass RLC circuit's behaviour under 100 Hz input frequency");
xlabel("Time(s)");
ylabel("Amplitude");

figure;
hold on;
plot(xf2(:, 2)*R);
plot(Vin2);
title("Band pass RLC circuit's behaviour under 1590 Hz input frequency");
xlabel("Time(s)");
ylabel("Amplitude");

figure;
hold on;
plot(xf3(:, 2)*R);
plot(Vin3);
title("Band pass RLC circuit's behaviour under 700 Hz input frequency");
xlabel("Time(s)");
ylabel("Amplitude");

figure;
hold on;
plot(xf4(:, 2)*R);
plot(Vin4);
title("Band pass RLC circuit's behaviour under 800 Hz input frequency");
xlabel("Time(s)");
ylabel("Amplitude");

% Calculate the resonant frequency 
resonant = find(band == max(band))*10;
% How are the shapes and/or amplitudes different?
% The filter is a bandpass filter. Frequencies at a narrow range around 1600 are
% allowed to pass, while at all other frequencies, the output voltage's amplitudes 
% are cut significantly. As
% the input's frequency grows higher, the output frequency increases as
% well. At the resonant frequency, the output amplitude gradually increases
% over time. Around the resonantn frequency, the overall amplitude changes
% over time. For low frequencies, the output is unstable in the beginning
% and gradually gets more stable. For high frequencies, 
% the output's amplitude is too low and frequency is too high to make useful observations:

%% For what frequencies𝑓 is the output approximately the same amplitude as the input? 
%And, for what frequencies is it much bigger? Or much smaller? 
%Would you call this circuit a “lowpass,” “bandpass,” or “highpass” filter? 
same = find(band>0.95 & band <1.05)*10; % find similar amplitude frequencies
bigger = find(band >1.5)*10; % Find bigger amplitude frequencies
smaller = find (band < 0.3)*10; % Find smaller amplitude frequencies

% Same contains values: 1520, 1660 and 1670. bigger contains values from
% 1570 to 1620. smaller contains values from 10 to 1340 and 1900 to 10000.
% This is a bandpass filter. 


%% Interpret what you hear in terms of what you see in the voltage vs. time graphs.
%What do small or large amplitudes sound like? What do small, medium, and large frequencies sound like?
playSound(xf1(:, 2)*R,  1/h); % Play the sound 
pause(1);
playSound(xf2(:, 2)*R,  1/h);
pause(1);
playSound(xf3(:, 2)*R,  1/h);
pause(1);
playSound(xf4(:, 2)*R,  1/h);
% I lengthened the number of time steps and hear different frequencies.
% Small amplitude sounds quieter and large amplitudes sound louder. Also,
% as frequency increases, the pitch of the sound increases. 