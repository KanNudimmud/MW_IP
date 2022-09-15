%% Harris Corner Detection
clear all, close all, clc

%% 
% Load the image
img = imread('leaf.jpg');

% Resize
img = imresize(img,0.6);

% Convert to double
img = im2double(img);

% Convert to grayscale
img = rgb2gray(img);

% Visualize it
figure, imshow(img)

% Define sobel filter
sobel = [-1 0 1;
    -2 0 2;
    -1 0 1];

% Define gaussian filter
gauss = fspecial('gaussian',5,1);

% Convolve filters
dog = conv2(gauss,sobel);

ix = imfilter(img,dog);
iy = imfilter(img,dog');

ix2g = imfilter(ix.*ix, gauss);
iy2g = imfilter(iy.*iy, gauss);

ixiyg = imfilter(ix.*iy, gauss);

% Correlation matrix
harcorr = ix2g.*iy2g - ixiyg.*ixiyg - 0.05*(ix2g+iy2g).^2;

figure, imshow(harcorr * 50)

% Define corners - thresholding -
corners = harcorr > 0.0001; % good result
figure,imshow(corners)

corners = harcorr > 0.00001;
figure,imshow(corners)

corners = harcorr > 0.000001;
figure,imshow(corners)

% Dilution
localmax = imdilate(harcorr,ones(3));
figure, imshow(harcorr == localmax)

figure, imshow((harcorr == localmax).*(corners))

% Put corners mask on the image
corvis = img;

corvis(corners>0) = 1;
figure,imshow(corvis)

%% end.