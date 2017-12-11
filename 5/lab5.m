tspan = [0 2000];
zmienne0 = [0.1 0.8 0.8];
xPlot = [];
yPlot = [];

for I = 0:0.01:4;
    
    [t, y] = ode45(@(t, zmienne) mydot(t, zmienne, I), tspan, zmienne0);
    [pks, locs] = findpeaks(y(3000:size(y(:,1),1)), t(3000:size(t)), 'MinPeakProminence', 2);
    data = double(uint8(diff(locs)));
    uvalues = unique(data);
    ucounts  = histc(data, uvalues);

    for i = 1:size(uvalues)
        if ucounts(i) > 1
            xPlot = [xPlot, I];
            yPlot = [yPlot, uvalues(i)];
        end
    end

end

scatter(xPlot,yPlot,'.')
        
