clc;clear;
close all;
%% Constants
FIGS = 10;
A = 0.5;
k = 2*pi;
D = 0.05;
U = 1;
n = 21;
h = 2/(n-1);
x = 0:h:2;
dt=0.05;
%%
y2 = A*sin(k*x); % Initial phase

for i=0:FIGS-1
    t=i*dt;
    y1 = exp(1)^(-D*k^2*t)*A*sin(k*(x-U*t));
    plot(1:n, y2, '-b', 'LineWidth', 2);
    hold on;
    plot(1:n, y1, '-r', 'LineWidth', 2);
    hold off;

    legend('Numerical', 'Exact');
    xlabel('n');ylabel('f');
    xlim([1 n]);ylim([-4*A 4*A]);
    str = sprintf("nstep=%d time=%.2f", i+1, t);
    text(11, -1, str, "Color", 'k', 'FontSize', 12); % Required

    %% Compute next numerical sequence
    newy=zeros(1, n);
    calc = @(a,b,c)(b-(c-a)*U*dt/2/h+(c-2*b+a)*D*dt/h/h); % shortcut
    for j=2:n-1
        newy(j) = calc(y2(j-1), y2(j), y2(j+1));
    end
    newy(1) = calc(y2(n-1), y2(1), y2(2)); % Special judge for boundaries
    % Regard node 1 and node n as the same node.
    % Then turn the sequence into a ring:
    % ...--(n-1)--(1|n)--2--3--...--(n-1)--(1|n)--2--3--...
    newy(n) = newy(1);
    y2=newy;
    %%

    pause(1);
end
