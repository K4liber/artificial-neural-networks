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

%Train the SVM Classifier
% 'linear' (default) | 'gaussian' | 'rbf' | 'polynomial' | function name
cl = fitcsvm(X,Y,'KernelFunction','linear',...
    'BoxConstraint',Inf,'ClassNames',[0,1], 'Standardize',true);

[label,score,cost] = predict(cl,inputs(451:568,:));
label
 correctness = 0.0;
for i=451:rawDataSize
    if label(i-450) == targets(i)
        correctness = correctness + 1.0/(rawDataSize+1-451);
    end
end
error = 1.0-correctness
