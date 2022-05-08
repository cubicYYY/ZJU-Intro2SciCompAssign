clear;clc;
x_in_rad = 0:pi/6:2*pi; % First column from 0 to 2π in steps of π/6
x_in_deg = rad2deg(x_in_rad); % Second column convert rad. to deg.
sinx = sin(x_in_rad); % Calculate sin(x), which constitutes column 3 
cosx = cos(x_in_rad); % Calculate cos(x), which constitutes column 4 
A = table(x_in_rad', x_in_deg', sinx', cosx',...
    'VariableNames', {'x(rad)', 'x(deg)', 'sin(x)', 'cos(x)'});
% Assemble the final array A and display it.
% Named argument for naming the variables.
% Note that here the ' notation is used for
% transpose the vectors, to make them filled column-by-column, 
% instead of row-by-row.
disp('The whole array looks like:');
disp(A);

% Extra work to visualize is followed here.
plot(x_in_rad, sinx, 'g'); 
hold on; % !Essential for add more curves in one plot figure
plot(x_in_rad, cosx, 'b'); 
legend('sin(x)','cos(x)')
title('A simple figure')
