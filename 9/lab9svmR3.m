%load data
rawData = readtable('wdbc.dat');
rawDataSize = size(rawData,1);
inputs = zeros(rawDataSize, 10);
targets = zeros(rawDataSize, 1);

for i=1:rawDataSize
    if strcmp(rawData{i,2}, 'M')
        targets(i) = 1;
    end
    inputs(i, 1:10) = rawData{i, 3:12};
end

X = inputs(1:450,:);
Y = targets(1:450);

% Reduce data dimension
[pc,score,latent,tsquare] = princomp(inputs);
pc,latent

X1s = [];
Y1s = [];
Z1s = [];
X2s = [];
Y2s = [];
Z2s = [];

for i=1:450
    if Y(i) == 1
        X1s = [X1s, score(i, 1)];
        Y1s = [Y1s, score(i, 2)];
        Z1s = [Z1s, score(i, 3)];
    else
        X2s = [X2s, score(i, 1)];
        Y2s = [Y2s, score(i, 2)];
        Z2s = [Z2s, score(i, 3)];
    end
end
          
%Train the SVM Classifier
% 'linear' (default) | 'gaussian' | 'rbf' | 'polynomial' | function name
cl = fitcsvm(score(1:450,1:3),Y,'KernelFunction','polynomial',...
    'BoxConstraint',Inf,'ClassNames',[0,1], 'Standardize',true);

[label,score,cost] = predict(cl,score(451:568,1:3));


correctness = 0.0;
for i=451:rawDataSize
    if label(i-450) == targets(i)
        correctness = correctness + 1.0/(rawDataSize+1-451);
    end
end
error = 1.0-correctness


