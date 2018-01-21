%params
inputsCount = 601;
data = zeros(400, inputsCount);
dataPerm = zeros(400, inputsCount);
dataToLearn = zeros(400, inputsCount-3);
dataToEncode = zeros(400, 3);
delimiterIn = '	';
headerlinesIn = 0;
dataPath = '/data/';
hiddenSize = 10;

% load data

for i = 1:inputsCount
    fileName = fullfile(pwd, strcat(strcat(dataPath, 'data'), num2str(i), '.txt'));
    input = importdata(fileName, delimiterIn,headerlinesIn);
    data(:,i) = input(:);
    strcat('file ', num2str(i), '/', num2str(inputsCount))
end

%}

% perm
p = randperm(inputsCount);
for i=1:inputsCount
    dataPerm(:,i) = data(:,p(i));
end

% data to learn
for i = 1:inputsCount-3
    dataToLearn(:,i) = dataPerm(:,i);
end

% data to encode
for i = inputsCount-2:inputsCount
    dataToEncode(:,i+3-inputsCount) = dataPerm(:,i);
end

autoenc = trainAutoencoder(data,hiddenSize,...
        'DecoderTransferFunction','purelin',...
        'L2WeightRegularization',0.001,...
        'SparsityRegularization',4,...
        'SparsityProportion',0.05);

predictions = predict(autoenc, dataToEncode);

input1 = reshape(dataToEncode(:,1),20,20);
predict1 = reshape(predictions(:, 1), 20, 20);
input2 = reshape(dataToEncode(:,2),20,20);
predict2 = reshape(predictions(:, 2), 20, 20);
input3 = reshape(dataToEncode(:,3),20,20);
predict3 = reshape(predictions(:, 3), 20, 20);

malaKaczkaColor = imread('malaKaczka.jpg');
malaKaczka = rgb2gray(malaKaczkaColor);
malaKaczkaMatrix = zeros(400, 1);
malaKaczkaMatrix(:,1) = malaKaczka(:);
predictKaczka = predict(autoenc, malaKaczkaMatrix);
predictKaczkaImg = reshape(predictKaczka, 20, 20);

in1 = encode(autoenc,dataToEncode(:,1));
out1 = reshape(decode(autoenc,in1),20,20);
in2 = encode(autoenc,dataToEncode(:,2));
out2 = reshape(decode(autoenc,in2),20,20);
in3 = encode(autoenc,dataToEncode(:,3));
out3 = reshape(decode(autoenc,in3),20,20);
in4 = encode(autoenc,malaKaczkaMatrix);
out4 = reshape(decode(autoenc,in4),20,20);

imshow([
    input1*255,out1*255,predict1*255;
    input2*255,out2*255,predict2*255;
    input3*255,out3*255,predict3*255;
    malaKaczka,out4*255,predictKaczkaImg*255
]);

RGBkaczka = imread('kaczka.jpg');
imageKaczka = im2double(RGBkaczka);

% 2 part
RGB = imread('baboon.jpg');
image1 = im2double(RGB);

RGB2 = imread('forest.jpg');
image2 = im2double(RGB);