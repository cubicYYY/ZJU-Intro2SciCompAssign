clear;clc;
saveSineWave('test');
plotSineWave('test');
% Make sure that the 'test.mat' file is under current working directory.
function saveSineWave(fileName)
x = -2*pi:pi/100:2*pi;
y = 5*sin(x) + 2;
save([fileName, '.mat'], 'x', 'y', '-mat'); % Manually add '.mat' suffix
end

function plotSineWave(fileName)
load([fileName, '.mat'], 'x', 'y', '-mat');
% Specific the variables to load to avoid possible conflict with functions
% or variables that already exist.
plot(x, y, '-k', 'LineWidth', 2);
xlabel('x');ylabel('y'); % Required: axis label
axis auto;
ylim([-4 8]); % Breathing room
set(gca,'XTick',-2*pi:pi/2:2*pi)
set(gca,'XTickLabel', ...
    {'-2*pi', '-3*pi/2', '-pi', '-pi/2', '0','pi/2','pi','3*pi/2','2*pi'});
set(gca,'FontSize', 12, 'FontName', 'Consolas'); % Bigger font
grid on;
legend('sin(x)', 'Location','northeast');
end