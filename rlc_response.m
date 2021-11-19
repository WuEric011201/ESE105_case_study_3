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
Vc_initial = 0; % Initial value of 0s
I_initial = 0;
% Populate the containers
Vin = zeros(steps+1, 1);
x = [Vc_initial , I_initial ; zeros(steps, 2)];
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

%% Questions
% The filter is a bandpass filter. Frequencies at a range around 1500 are
% allowed to pass, while all other frequencies have their amplitudes cut
% significantly

%% You can fix this later, basically automated with diff num frequencies
% numFrequency = size(frequencies, 2);
% 
% % Make array that is A repeated num frequency js
% multipleA = repmat({A}, 1, numFrequency);
% % Make 2*num x 2*num, where diag are A
% Aadjusted = blkdiag(multipleA{:});
% 
% 
% Badjusted = B;
% input = [Vc, I];
% for count = 1:numFrequency-1
%     Badjusted = [Badjusted; B];
%     input = [input, [Vc, I]];
% end
% 
% Vins = zeros(steps, numFrequency);
% % Vins with columns duplicated for later
% Vins2 = zeros(steps, numFrequency*2);
% % Constructs the v in for every frequency we are testing
% for j = 1:steps
%     t = h*j;
%     Vins(j, :) = sin(2.*pi.*frequencies.*t);
%     for count = 1: numFrequency
%         Vins2(j, count:count+1) = sin(2.*pi.*frequencies(count).*t);
%     end
% end
% 
% % Make 2*num frequency columns (1 column for v, one for i) and k j rows
% xResponse = [input; zeros(steps, numFrequency*2)];
% for k=2: steps
%     xResponse(k, :) = Aadjusted*(xResponse(k-1, :)')+Badjusted.*Vins2(k-1, :)';
% end
