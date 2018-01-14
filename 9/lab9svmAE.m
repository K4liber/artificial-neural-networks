%load data
rawData = readtable('wdbc.dat');
rawDataSize = size(rawData,1);
inputs = zeros(rawDataSize, 10);
targets = zeros(rawDataSize, 1);

PCA = 4;

%normalize data
for i=1:10
    rawData{:, 2+i} = (rawData{:, 2+i} - min(rawData{:, 2+i})) ...
        / ( max(rawData{:, 2+i}) - min(rawData{:, 2+i}) );
end

for i=1:rawDataSize
    if strcmp(rawData{i,2}, 'M')
        targets(i) = 1;
    end
    inputs(i, 1:10) = rawData{i, 3:12};
end

X = inputs(1:450,:);
Y = targets(1:450);

%autoencoder
hiddenSize = 3;
%autoenc1 = trainAutoencoder(X,hiddenSize,...
 %   'L2WeightRegularization',0.001,...
  %  'SparsityRegularization',4,...
   % 'SparsityProportion',0.05,...
   % 'DecoderTransferFunction','purelin');

% Reduce data dimension
[pc,score,latent,tsquare] = princomp(inputs);
pc,latent;
cumsum(latent)./sum(latent)
          
%Train the SVM Classifier
% 'linear' (default) | 'gaussian' | 'rbf' | 'polynomial' | function name
cl = fitcsvm(score(1:450,1:PCA),Y,'KernelFunction','linear',...
    'BoxConstraint',Inf,'ClassNames',[0,1], 'Standardize',false);

[label,s,cost] = predict(cl,score(451:568,1:PCA));

correctness = 0.0;
correct = 0;
missed = 0;
for i=451:rawDataSize-1
    if label(i-450) == targets(i)
        correctness = correctness + 1.0/(rawDataSize-450.0);
        correct = correct + 1;
    else
        missed = missed + 1;
    end
end
error = 1.0-correctness
missed
correct


