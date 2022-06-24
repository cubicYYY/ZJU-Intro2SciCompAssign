clc;clear;
msd_posVel(0.2, 0.1, 2, 10, 5, 0, 100);
msd_water(0.2, 0.1, 0:0.1:20, 10, 5, 0, 300);

function dy = msd(t, y, c, k, m)
% y1'=y2
% y2'=(-c*y2-k*y1)/m
dy=[y(2);(-c.*y(2)-k.*y(1))./m]; % Equations(given)
end

function msd_posVel(c, k, m, yi, vi, t_beg, t_end)
figure;
tspan = [t_beg, t_end];
[t, x]=ode45(@msd, tspan, [yi vi], [], c, k, m);
% Extra arguments is acceptable
% [yi vi] specifics initial conditions
% [] stands for no extra options

[Ax, C1, C2] = plotyy(t, x(:,1), t, x(:,2));
% plotyy is deprecated, but stick to it since it is required to use :)
title('msd pos. and vel.');

%% Style Settings
set(gcf, 'Color', 'w');
set(Ax, 'FontName', 'Consolas', 'FontSize', 12);
xlabel('Time (sec)');
set(get(Ax(1), 'Ylabel'), 'string', 'Position (m)');
set(get(Ax(2), 'Ylabel'), 'string', 'Velocity (m/s)');
set(Ax(1), 'ylim', [-20, 30]);set(Ax(2), 'ylim', [-4, 6]);
set(Ax(1), 'ycolor', 'b');set(Ax(2), 'ycolor', 'r'); % Match the curves
set(Ax, 'Xlim', [0, 100]);
set(C1, 'Linestyle', '-', 'color', 'b', 'Linewidth', 2);
set(C2, 'Linestyle', '-', 'color', 'r', 'Linewidth', 2);
grid off; % No grid
hold off;
end

function msd_water(c, k, m, yi, vi, t_beg, t_end)
figure;set(gcf, 'Color', 'w');
N = length(m);
x = linspace(t_beg, t_end, N);
y = m;
Z = zeros(length(x), N, 2); % Pre-allocating for speeding
for i=1:N % Compute data points for different m
    [~, Z(:,i,:)]=ode45(@msd, x, [yi vi], [], c, k, m(i));
end
[X, Y] = meshgrid(x, y);
plot3(X', Y', Z(:,:,1), 'k');
set(gca, 'FontName', 'Consolas', 'FontSize', 10);
xlabel('Time (s)');ylabel('Mass (kg)');zlabel('Position (m)');
view(-15, 55);
box off;grid off;hold off;axis tight;
end
