%params
hiddenSize = 10;
N = 8*ones(1,64); 
inputs = zeros(64, 4096);

baboonColor = imread('baboon.jpg');
baboonDouble = im2double(rgb2gray(baboonColor));
dataBaboon = mat2cell(baboonDouble,N,N);

forestColor = imread('forest.jpg');
forestDouble = im2double(rgb2gray(forestColor));
data = mat2cell(forestDouble,N,N);

% create inputs as vectors
for i=1:4096
    tmp = data{i};
    inputs(:,i) = tmp(:)';
end

autoenc = trainAutoencoder(inputs,hiddenSize,...
        'DecoderTransferFunction','purelin',...
        'L2WeightRegularization',0.001,...
        'SparsityRegularization',4,...
        'SparsityProportion',0.05);

% forest predict
output = zeros(4096,64);
for i=1:4096
    in1 = encode(autoenc,data{i}(:));
    out1 = decode(autoenc,in1);
    output(i,:) = out1(:)';
end

output2=zeros(512,512);
z=1;
for j=1:64
    for i=1:64
        output2((i-1)*8+1:i*8, (j-1)*8+1:j*8) = reshape(output(z,:)',[8,8]); 
        z=z+1;
    end
end

% baboon predict
outputBaboon = zeros(4096,64);
for i=1:4096
    in1 = encode(autoenc,dataBaboon{i}(:));
    out1 = decode(autoenc,in1);
    outputBaboon(i,:)=out1(:)';
end

outputBaboon2=zeros(512,512);
z=1;
for j=1:64
    for i=1:64
        outputBaboon2((i-1)*8+1:i*8, (j-1)*8+1:j*8) = reshape(outputBaboon(z,:)',[8,8]); 
        z=z+1;
    end
end

figure
subplot(2,2,1); 
imshow(forest);
subplot(2,2,2); 
imshow(output2);
subplot(2,2,3); 
imshow(baboon);
subplot(2,2,4); 
imshow(outputBaboon2);