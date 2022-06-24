function gauge = fuelbar(uif,x,y,size,fuel)
gauge(1) = uigauge(uif,'semicircular');
gauge(1).ScaleColors = {'red','yellow','green'};
gauge(1).ScaleColorLimits = [0 30; 30 70;70 100];
gauge(1).Position = [x y size size];
gauge(1).Value=fuel;
% fuelGauge.Text='Fuel Remaining';

gauge(2) = uilabel(uif);
gauge(2).HorizontalAlignment = 'center';
gauge(2).Position = [x y-size*0.6 size size];
gauge(2).Text = sprintf('Fuel:%d%%',floor(fuel));
end