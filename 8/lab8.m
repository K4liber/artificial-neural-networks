%params
hiddenLayerSize = 10;
epochs = 17;
inputsCount = 601;
inputs = zeros(400, inputsCount);
vPerfs = zeros(hiddenLayerSize, epochs+1);
delimiterIn = '	';
headerlinesIn = 0;
dataPath = 'Desktop/Link to EDMI - SEM1/LSSN/8home/data/';

%load data
for i = 1:inputsCount
    fileName = fullfile(pwd, strcat(strcat(dataPath, 'data'), num2str(i), '.txt'));
    input = importdata(fileName, delimiterIn,headerlinesIn);
    inputs(:,i) = input(:);
    strcat('file ', num2str(i), '/', num2str(inputsCount))
end

targetsFileName = fullfile(pwd, strcat(dataPath,'targets.txt'));
targetsData = importdata(targetsFileName, delimiterIn,0);
targets = targetsData(:,2);
targets = targets.';
    
% main loop

for i = 1:hiddenLayerSize
    for j = 1:5
        net = fitnet(i);
        net.trainFcn = 'trainscg';
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
        vPerfs(i,:) = vPerfs(i,:) + tr.vperf;
    end
    vPerfs(i,:) = vPerfs(i,:)/5.0;
end

surf(2:8, 1:10, vPerfs(:,2:8))
%outputs = net(inputs);
%errors = gsubtract(targets, outputs);
%performance = perform(net, targets, outputs);
zlabel('Vperf')
xlabel('epochs')
ylabel('hnn')
%view(net)
