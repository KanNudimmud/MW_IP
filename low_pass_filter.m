%% Spatial- Domain Low-Pass Filter Implementation
clear all, close all, clc
%% Download the original image
lenna = imread('1.gif');
imshow(lenna)
%% Convert image type to double
lennaD = im2double(lenna);
%% Create a 3x3 low-pass filter
filter = [1/9 1/9 1/9;
    1/9 1/9 1/9;
    1/9 1/9 1/9];
%% Filter the original image
lennaDf = imfilter(lennaD,filter,'replicate');
imshow(lennaDf)
%% Compute PSNR 
psnr(lennaDf,lennaD)
%% Compute PSNR for a different filter
filter2 = ones(5,5) * 1/25;

lennaDf2 = imfilter(lennaD,filter2,'replicate');

psnr(lennaDf2,lennaD)

%% end.