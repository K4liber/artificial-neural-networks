% Zad 1

% Nie do konca wiem co tu robic...
% Kaczke bedzie trzeba zmniejszyc (resize)
% Przelosowac, bo droga przesunieta tylko w kolejnych krokach
% Pamietac, zeby byly to double jak alvin
% https://www.mathworks.com/matlabcentral/answers/104159-how-to-using-my-own-cod                                                                                        e-to-resize-image

% Zad 2

forest_path = 'forest.jpg';
baboon_path = 'baboon.jpg';

forest = imread(forest_path);
baboon = imread(baboon_path);

% 2grayscale

forest = rgb2gray(forest);
baboon = rgb2gray(baboon);

% tu musze podzielic obrazki na ramki 8x8

[r c] = size(forest);
bs=64; % Block Size (64x64)
nob=64 % Total number of 64x64 Blocks
% Dividing the image into 64x64 Blocks
kk=0;
l=0;
[F]=zeros(1,64);
%[B0]=zeros(64,64);

dataset_train = zeros(bs * bs, nob);
n = 0;

for i=1:(r/bs)
        for j=1:(c/bs)
                B0=forest((bs*(i-1)+1:bs*(i-1)+bs),(bs*(j-1)+1:bs*(j-1)+bs));
        n = n + 1;
        end
        kk=kk+(r/bs);
