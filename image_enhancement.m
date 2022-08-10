%% Image Enhancement
clear all, close all, clc
%% Load images
noisy      = imread('noisy.jpg');
noise_free = imread('noisy_original.jpg');

noisyD = im2double(noisy);
noise_freeD = im2double(noise_free);

%% Perform median filtering
% 3x3 filter
filtered = medfilt2(noisyD,[3 3]);
imshow(filtered)

% Two-pass filter
filtered2 = medfilt2(filtered,[3 3]);
imshow(filtered2)

%% Compute PSNRs
% between noise-free and noisy inputs
psnr(noisyD, noise_freeD)

% between noise-free and 1-pass filtered images
psnr(filtered, noise_freeD)

% between noise-free and 2-pass filtered images
psnr(filtered2, noise_freeD)

%% Visualiziation
figure
subplot(221)
imshow(noise_freeD),title('Original Image')

subplot(222)
imshow(noisyD),title('Noisy Image')

subplot(223)
imshow(filtered),title('1-pass Filtered Image')

subplot(224)
imshow(filtered2),title('2-pass Filtered Image')

%% end.