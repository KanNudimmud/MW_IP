%% Finding and Analyzing Objects
% Image is obtained from:
% https://codewords.recurse.com/issues/six/image-processing-101
%% Counting Money
% Load the image
coins = imread("coins.jpg");

% Conver the image to 2-D
coins = coins(:,:,1);

% Display the original image
figure(1),subplot(311)
imshow(coins),title('Original Image')

% Binarize the image
Bcoins = imbinarize(coins);
figure(1),subplot(312)
imshow(Bcoins),title('Binarized Image')

% Create a mask
Maskcoins = imfill(~Bcoins,'holes');
figure(1),subplot(313)
imshow(Maskcoins),title('Masked Image')

% Filter the image to get only nickels that have an area 20000-30000 pixels
nickel = bwpropfilt(Maskcoins,'Area',[20000 30000]);

% Filter the image to get only dimes that have an area lower than 20000
% pixels
dime = bwpropfilt(Maskcoins,'Area',[10000 20000]);

% Display both filtered images
figure(2),subplot(121)
imshow(nickel),title('Nickels')

subplot(122),imshow(dime)
title('Dimes')

% Find connected components to reach the number of nickels or dimes
CCnickel = bwconncomp(nickel);
CCdime   = bwconncomp(dime);

% Extract number of elements in the image seperately
numNickel = CCnickel.NumObjects;
numDime   = CCdime.NumObjects;

% Calculate the amount of money
money = numNickel * .05 + numDime * .1;

%% Labeling Coins
% Find the connected components of masked coins
coinsCC = bwconncomp(Maskcoins);

% Create a label matrix
coinsLab = labelmatrix(coinsCC);

% Convert the label matrix to RGB
coinsRGB = label2rgb(coinsLab);

% Display both version
figure(3),subplot(311)
imshow(~coinsLab)
title('Label Matrix of Coins')

subplot(312)
imshow(coinsRGB)
title('Image of the Label Matrix')

% Modify the RGB version
coinsRGB = label2rgb(coinsLab,'autumn','k','shuffle');

subplot(313)
imshow(coinsRGB)
title('Modified Image of the Label Matrix')

%% Detecting Circles
% Find Circles and radius
[c,r] = imfindcircles(coins,[60 200],...
    'ObjectPolarity','dark',...
    'Sensitivity',.9);
% Visualize coins
figure(4)
imshow(coins)
viscircles(c,r);
title('Marked Coins')

% Display dimes
idxD = r < 75;
figure(5)
imshow(coins)
viscircles(c(idxD,:),r(idxD));
title('Marked Dimes')

%% end