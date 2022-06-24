clc;clear;

ntimesteps = 20000;
xt = lotkaVolterra([1, 1], 1, 2.5, 1, 2.5, 0.001, ntimesteps);
figure;
plot(1:ntimesteps, xt(1,:), '-', 'LineWidth', 1, 'color', 'blue');
% prey, blue
hold on;
plot(1:ntimesteps, xt(2,:), '-', 'LineWidth', 1, 'color', [0.4 0.7 0.4]); %
% predator, deep green.
xlabel('Time');ylabel('Population');
legend('Prey', 'Predator');
set(gca, 'FontSize', 8, 'LineWidth', 1);
axis auto;

function state = lotkaVolterra (initial_state, alpha, beta, gamma, delta, dt, ntimesteps)
LotkaVolterra = @(t, x) [
    alpha*x(1)-beta*x(1)*x(2);
    -gamma*x(2)+delta*x(1)*x(2)]; % Derived from given equations
t = 0:dt:ntimesteps*dt-dt; % Total counts: ntimesteps
assert(ntimesteps==length(t)); % Required
[~, state] = ode45(LotkaVolterra, t, initial_state);
state = state'; % Just to meet requirements in problem

end