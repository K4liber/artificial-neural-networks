%load data
rawData = readtable('wdbc.dat');
rawDataSize = size(rawData,1);
inputs = zeros(10, rawDataSize);
targets = zeros(1, rawDataSize);

for i=1:rawDataSize
    if strcmp(rawData{i,2}, 'M')
        targets(i) = 1;
    end
    inputs(1:10, i) = rawData{i, 3:12};
end

%params
epochs = 60;
series = 100;

outputs8 = networktrain([8,5,4], epochs, series, inputs, targets);
outputs7 = networktrain([7,5,4], epochs, series, inputs, targets);
outputs6 = networktrain([6,5,4], epochs, series, inputs, targets);
outputs5 = networktrain([5,5,4], epochs, series, inputs, targets);

dlmwrite('MLP450bfg5hnn.dat',outputs5)
dlmwrite('MLP450bfg6hnn.dat',outputs6)
dlmwrite('MLP450bfg7hnn.dat',outputs7)
dlmwrite('MLP450bfg8hnn.dat',outputs8)

plot(3:epochs+1, outputs8(3:epochs+1), 'r',3:epochs+1, outputs7(3:epochs+1), 'b', 3:epochs+1, outputs6(3:epochs+1), 'g',3:epochs+1, outputs5(3:epochs+1), 'y')
title('Vperf for different sizes of hiden layer.')
legend('hnn = 8','hnn = 7','hnn = 6','hnn = 5')
xlabel('epoch')
ylabel('Vperf')

min(outputs8)
min(outputs7)
min(outputs6)
min(outputs5)


