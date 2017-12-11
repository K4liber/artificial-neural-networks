load bodyfat_dataset
inputs = bodyfatInputs;
targets = bodyfatTargets;

[inputs,targets] = bodyfat_dataset;

hiddenLayerSize = [10];
net = fitnet(hiddenLayerSize);

%view(net)

net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 5/100;

%net.trainParam.min_grad = 
%net.trainParam.max_fail = 
%net.trainParam.time = 
%net.trainParam.goal = 0.9
%net.trainParam.epochs = 

[net, tr] = train(net, inputs, targets);

outputs = net(inputs);
errors = gsubtract(targets, outputs);
performance = perform(net, targets, outputs)

%view(net)
