clear;clc;
load poly.mat X Y;
[R2,N85,p]=discoverDegree(X,Y,0.85);
plot(X,Y, 'bo');
xlim([-10 10]);
ylim([-40 40]);
hold on;
plot(X,polyval(p,X),'r-','LineWidth',1.5); % Pretty plot
title('a fit for R^2\geq0.85'); % a title that fits for a fit
legend('Data', 'Polynomial Fit', 'Location','southeast');
% Required: legend
xlabel('x');ylabel('y'); % Required:label
[~,N95,~]=discoverDegree(X,Y,0.95);
disp([N85, N95]); % Generate answer for questions
%% Answer:
% For R^2≥0.85, 3 polynomial degree is needed;
% For R^2≥0.95, 5 polynomial degree is needed.
%%
function [R2out,pOrder,pCoeff] = discoverDegree(x,y,R2crit)
mean_y = mean(y);
pOrder = 1;
pCoeff=polyfit(x,y,pOrder);
R2out = 1-sum((y-polyval(pCoeff,x)).^2)/sum((y-mean_y).^2);
while R2out<R2crit
    pOrder = pOrder+1;
    pCoeff=polyfit(x,y,pOrder);
    R2out = 1-sum((y-polyval(pCoeff,x)).^2)/sum((y-mean_y).^2);
end
end

