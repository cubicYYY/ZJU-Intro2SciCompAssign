clear;clc;
figure('units','normalized','outerposition',[0 0 1 1]); % Full screen
subplot(2,2,1);seedsPlot(137.513);
title('Sunflower');set(gca, 'RTick', []);
% To make it a bit more accurate: 137.51(3) (deg)

subplot(2,2,2);seedsPlot(137.45);
title('Spokes1');set(gca, 'RTick', []);

subplot(2,2,3);seedsPlot(137.65);
title('Spokes2');set(gca, 'RTick', []);

subplot(2,2,4);seedsPlot(137.92);
title('Catherine wheels');set(gca, 'RTick', []);
set(gcf, 'Color', 'w'); % white figure background

function seedsPlot(d)
N = 1:500; % Sufficient to show the tendency
theta = pi*d/180*N;
rho = sqrt(N);
polarplot(theta, rho, 'ro', 'MarkerSize', 3);
% NOTE: function "polar" is being deprecated. So I use "polarplot" instead
end