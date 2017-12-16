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
cumsum(latent)./sum(latent)

X1s = [];
Y1s = [];
X2s = [];
Y2s = [];

pX1s = [];
pY1s = [];
pX2s = [];
pY2s = [];

for i=1:450
    if Y(i) == 1
        X1s = [X1s, score(i, 1)];
        Y1s = [Y1s, score(i, 2)];
    else
        X2s = [X2s, score(i, 1)];
        Y2s = [Y2s, score(i, 2)];
    end
end
          
%Train the SVM Classifier
% 'linear' (default) | 'gaussian' | 'rbf' | 'polynomial' | function name
cl = fitcsvm(score(1:450,1:2),Y,'KernelFunction','linear',...
    'BoxConstraint',Inf,'ClassNames',[0,1], 'Standardize',true);

[label,s,cost] = predict(cl,score(451:568,1:2));
cl.Beta(1)
cl.Beta(2)
xLinear = 1:5;
yLinear = cl.Beta(2)*xLinear + cl.Beta(1);

for i=451:rawDataSize
    if label(i-450) == 1
        pX1s = [pX1s, score(i, 1)];
        pY1s = [pY1s, score(i, 2)];
    else
        pX2s = [pX2s, score(i, 1)];
        pY2s = [pY2s, score(i, 2)];
    end
end

correctness = 0.0;
for i=451:rawDataSize
    if label(i-450) == targets(i)
        correctness = correctness + 1.0/(rawDataSize+1-451);
    end
end
error = 1.0-correctness

scatter(X1s,Y1s,15,'MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[0 .5 .5],...
              'LineWidth',0.5);
hold on;

scatter(X2s,Y2s,15,'MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[1 .0 .0],...
              'LineWidth',0.5);
hold on;

scatter(pX1s,pY1s,15,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[0 .5 .5],...
              'LineWidth',0.5);
hold on;

scatter(pX2s,pY2s,15,'MarkerEdgeColor',[0 0 0],...
              'MarkerFaceColor',[1 .0 .0],...
              'LineWidth',0.5);
hold on;

plot(xLinear, yLinear);
legend({'Train M','Train B', 'Test M', 'Test B', 'Support Vectors'});

xlabel('x1')
ylabel('x2')

