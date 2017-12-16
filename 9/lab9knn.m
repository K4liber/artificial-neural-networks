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

maxNN = 200;
errors = zeros(maxNN, 1);

for j=1:maxNN;
    Mdl = fitcknn(X, Y,'NumNeighbors',j);
    %rloss = resubLoss(Mdl)
    %CVMdl = crossval(Mdl)
    %kloss = kfoldLoss(CVMdl)

    correctness = 0.0;
    for i=451:rawDataSize
        class = predict(Mdl,inputs(i,:));
        if class == targets(i)
            correctness = correctness + 1.0/(rawDataSize+1-451);
        end
    end
    errors(j) = 1.0-correctness;
    strcat(num2str(j*100.0/maxNN), ' %')
end

plot(1:maxNN, errors);


