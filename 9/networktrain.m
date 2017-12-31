function [outputs, MINIMUM, middleMin, middleStd] = networktrain(hiddenLayerSize, epochs, series, inputs, targets)
    outputs = zeros(1, epochs+1);
    MINIMUM = 1;
    for i=1:series
        net = fitnet(hiddenLayerSize);
        net.trainFcn = 'trainbfg';
        %trainlm
        %trainbfg
        %trainscg
        net.divideFcn = 'dividerand';
        net.divideParam.trainRatio = 450/568;
        net.divideParam.valRatio = 59/568;
        net.divideParam.testRatio = 59/568;
        net.trainParam.min_grad = 0;
        net.trainParam.max_fail = epochs;
        net.trainParam.epochs = epochs; 
        [~, tr] = train(net, inputs, targets);
        outputs = outputs + tr.vperf;
        if MINIMUM > min(tr.vperf)
            MINIMUM = min(tr.vperf);
        end
        i
    end
    outputs = outputs/series;
    MINIMUM;
end