% Symbolic Math Toolbox must be installed first
clear;clc;
%% Derivative
syms x y z n;
fxy=cos(x)*sin(y)+y^3*log(x);
disp(diff(fxy,'x'));
%% Divergence
Fxyz=[2*(cos(x))^2 (sin(y))^3 2*x^2+y^2+4*z^2];
disp(divergence(Fxyz,[x,y,z]));
%% Gradient
fxyz=x^2+2*y^2+4*z^2;
disp(gradient(fxyz));
%% Integral
fx=x^2-5*x;
disp(int(fx));
fx=x^(2-n)-5*x;
disp(int(fx,x));
%% Triple Integration
fxyz=sin(x)*cos(y)*tan(z)+y*cos(x)+x*sin(y);
disp(simplify(int(int(int(fxyz,x),y),z))); %simplify for pretty answer
