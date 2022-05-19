clear;clc;
load('AFMdata0001.mat', 'current', 'friction', 'height', '-mat');
plotAFMdata(height, friction, current, 200, 'AFM_Visualize');

function plotAFMdata(H, F, I, ss, saveName)
%% Arguments Checking
[row, col] = size(H);
assert(row==col);
assert(all(size(H)==size(F)));
assert(all(size(I)==size(F)));
Xcor = linspace(0, ss, row);
Ycor = linspace(0, ss, col); % X-Y surface division

%% Figure Initialization
figure;
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'Color', 'w'); % Required: white figure background
screen_rect = get(0, 'ScreenSize');
screen_width = screen_rect(3);
screen_height = screen_rect(4);
figure_width = 1000;
figure_height = 460; % Required figure size
set(gcf, 'position', [ ...
    screen_width/2-figure_width/2, screen_height/2-figure_height/2, ...
    figure_width, figure_height]);
% Required: Figure in the center of the screen

%% Axes1: F(x, y)
plotFxy = subplot(2, 2, 3);
[X, Y] = meshgrid(Xcor, Ycor);
surf(X, Y, F);
set(gca,'FontSize', 9, 'FontName', 'Consolas');
xlabel('nm');ylabel('nm');zlabel('nm');
title('Friction overlaid height');
shading interp; % Smooth color shifting when hegiht changes
cb1 = colorbar;
title(cb1, 'Friction (mV)');
colormap(plotFxy, "jet"); % Respectively dispatch styles
view(-40, 60); % Required: specific azimuth and elevation
grid off; % Required: no grid
box on; ax = gca;ax.BoxStyle = "full"; % Required: fully bounding box
axis tight; % Required: axis extend no further than the data range

%% Axes2: I(x, y)
plotIxy = subplot(2, 2, 4);
[X, Y] = meshgrid(Xcor, Ycor);
surf(X, Y, I);
set(gca,'FontSize', 9, 'FontName', 'Consolas');
xlabel('nm');ylabel('nm');zlabel('nm');
title('Current overlaid height');
shading interp;
cb2 = colorbar;
title(cb2, 'Current Response (V)');
colormap(plotIxy, "parula");
view(-40, 50); % Required: specific azimuth and elevation
grid off; % Required: no grid
box on; ax = gca;ax.BoxStyle = "full"; % Required: fully bounding box
axis tight; % Required: axis extend no further than the data range

%% Axes3: I(F)
subplot(2, 2, 1);
scatter(F, I, 1, 'black', '.');
set(gca,'FontSize', 9, 'FontName', 'Consolas');
% Required: specific font size&name for *ALL* text elements
% Same afterwards
% Note: This must be set after plotting since the plot/scatter reset axes
xlabel('Friction (mV)');
ylabel('Current response (V)');
title('Current response as a function of friction');
axis auto; % Required: Auto axis

%% Axes4: Current histogram
subplot(2, 2, 2);
histogram(I);
set(gca,'FontSize', 9, 'FontName', 'Consolas');
xlabel('Current response (V)');
ylabel('Counts');
title('Current histogram');
xlim([-1 7]); % Required: specific domain of -1 to 7
% no specific range

%% Save&Exit
% Required: save image to 24-bit jpeg file with resolution of
% 300pixels/inch, then close the figure window
print(gcf, '-djpeg', '-r300', saveName);
% -djpeg stands for 24-bit color depth implicitly
% Note: MATLAB for Windows: 1/96 inch/pixel
% Therefore expected image size is 3125 x 1437
% 1000/96*300 = 3125
% 460/96*300 = 1437.5

%% Alternative
% sgtitle('Figure saved as image!', ...
%     'Color','b', 'FontSize', 12, 'FontName', 'Consolas');
% !Only available in version MATLAB 2018b or later
pause(3);
% in case when your computer is too fast to have a glimpse of the figure!
close(gcf);

end