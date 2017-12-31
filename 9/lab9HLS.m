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
epochs = 200;
series = 100;

[outputs, MINIMUM] = networktrain([8,6,4,2], epochs, series, inputs, targets);

plot(3:epochs+1, outputs(3:epochs+1), 'r')
title('Vperf for different sizes of hiden layer.')
legend('hnn = 8','hnn = 7','hnn = 6','hnn = 5')
xlabel('epoch')
ylabel('Vperf')

MINIMUM
minMiddle = min(outputs)

