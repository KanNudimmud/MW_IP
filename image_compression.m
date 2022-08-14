%% Image Compression
clear all,close all, clc
%% Load the image and convert to JPEG
img = imread("Cameraman256.bmp");

imwrite(img,'Compressed Cameraman.jpg','jpg','Quality',75);
imwrite(img,'Compressed Cameraman2.jpg','jpg','Quality',10);

%Read compressed images
imgJ  = imread("Compressed Cameraman.jpg");
imgJ2 = imread("Compressed Cameraman2.jpg");

% Convert to double for calculations
imgD   = im2double(img);
imgJD  = im2double(imgJ);
imgJD2 = im2double(imgJ2);

%% Compute PSNR
psnr(imgJD,imgD)

psnr(imgJD2,imgD)

%% Visualization
figure
subplot(131)
imshow(img),title('Original Image')

subplot(132)
imshow(imgJ),title('Compressed Image with 75 quality score')

subplot(133)
imshow(imgJ2),title('Compressed Image with 10 quality score')

%% end.