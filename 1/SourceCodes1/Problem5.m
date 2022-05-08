clear;clc;
figure(1);% Seperated window for different curves
spirograph(5,1,0.4);
figure(2);
spirograph(12,-1,1.5);
figure(3);
spirograph(7,-1,1);
function spirograph(R,r,d)
theta = 0:0.0005:10*pi; % Generate theta vector in steps=0.0005 rad
x = cos(theta)*(R+r)+cos(theta*(R+r)/r)*d; % Generate x vector without loop
y = sin(theta)*(R+r)-sin(theta*(R+r)/r)*d; % The same to y vector
plot(x,y,'-c',...
    'LineWidth',2); % Try to change the style/color/width!
grid on; % Display grid on background
title('Beautiful Curve for You');
legend('roulette')
end