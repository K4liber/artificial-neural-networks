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
hiddenLayerSize = 6;
epochs = 7;
vPerfs = zeros(hiddenLayerSize, epochs+1);

net = fitnet(hiddenLayerSize);
%net.trainFnc = 'trainlm';
%trainlm
%trainbfg 
%trainscg
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 20/100;
net.trainParam.min_grad = 0;
net.trainParam.max_fail = epochs;
net.trainParam.epochs = epochs; 
[net, tr] = train(net, inputs, targets);
tr.vperf


