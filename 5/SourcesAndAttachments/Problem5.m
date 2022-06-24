clear;clc;
%% initial conditions
t=struct(); % create struct
x=struct();
dx=struct();
d2x=struct();
t.raw = [0, 1, 2.5, 5.0, 10.5, 12.5, 16, 20.5, 26.5, 30.5, 32];
x.raw = [0, 0.3, 1.2, 1.3, 1.6, 2.2, 2.4, 3.0, 3.6, 4.5, 4.6];
domain=linspace(0,32,100);

%% data generation
x.interp.linear = interp1(t.raw,x.raw,domain,'linear');
x.interp.spline = interp1(t.raw,x.raw,domain,'spline');
dx.interp.linear = diff(x.interp.linear)*100/32;
dx.interp.linear(end+1)=dx.interp.linear(end);
% 1 element is dropped after diff, must add an extra value
dx.interp.spline = diff(x.interp.spline)*100/32;
dx.interp.spline(end+1)=dx.interp.spline(end);

d2x.interp.linear = diff(dx.interp.linear)*100/32;
d2x.interp.linear(end+1) = d2x.interp.linear(end);

d2x.interp.spline = diff(dx.interp.spline)*100/32;
d2x.interp.spline(end+1) = d2x.interp.spline(end);

%% Linear
figure('units','normalized','outerposition',[0 0 1 1]);
% Full screen
set(gcf, 'Color', 'white');
ax1 = axes('Position', [.1  .69  .8  .23]);% Manually specific position
plot(domain,x.interp.linear, 'k-', 'LineWidth',1.5);
set(ax1, 'Xticklabel', [], 'LineWidth', 1, 'FontSize', 11); % Remove label
xlim(ax1, [0 32]);ylim(ax1, [0 6]);
ylabel(ax1, 'x (m)');
hold on;
plot(t.raw,x.raw, 'k.', 'MarkerSize',20); % Plot raw data as markers
hold off;

ax2 = axes('Position', [.1  .42  .8  .23]);
plot(domain,dx.interp.linear, 'k-', 'LineWidth',1.5);
set(ax2, 'Xticklabel', [], 'LineWidth', 1, 'FontSize', 11);
xlim(ax2, [0 32]);ylim(ax2, [0 1]);
ylabel(ax2, 'dx/dt (m/s)');

ax3 = axes('Position', [.1  .15  .8  .23]);
plot(domain,d2x.interp.linear, 'k-', 'LineWidth',1.5);
set(ax3, 'LineWidth', 1, 'FontSize', 11);
xlim(ax3, [0 32]);ylim(ax3, [-2 1]);
ylabel(ax3, 'd^2x/dt^2 (m/s^2)');
xlabel('Times (s)');
%% Spline
figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf, 'Color', 'white');
ax1 = axes('Position', [.1  .69  .8  .23]);
plot(domain,x.interp.spline, 'k-', 'LineWidth',1.5);
set(ax1, 'Xticklabel', [], 'LineWidth', 1, 'FontSize', 11);
xlim(ax1, [0 32]);ylim(ax1, [0 6]);
ylabel(ax1, 'x (m)');
hold on;
plot(t.raw,x.raw, 'k.', 'MarkerSize',20);
hold off;

ax2 = axes('Position', [.1  .42  .8  .23]);
plot(domain,dx.interp.spline, 'k-', 'LineWidth',1.5);
set(ax2, 'Xticklabel', [], 'LineWidth', 1, 'FontSize', 11);
xlim(ax2, [0 32]);ylim(ax2, [-1 1]);
ylabel(ax2, 'dx/dt (m/s)');

ax3 = axes('Position', [.1  .15  .8  .23]);
plot(domain,d2x.interp.spline, 'k-', 'LineWidth',1.5);
set(ax3, 'LineWidth', 1, 'FontSize', 11);
xlim(ax3, [0 32]);ylim(ax3, [-2 1]);
ylabel(ax3, 'd^2x/dt^2 (m/s^2)');
xlabel('Times (s)');








