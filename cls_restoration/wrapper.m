clear all
close all

%% Simulate 1-D blur and noise
image_original = im2double(imread('Cameraman256.bmp', 'bmp'));
[H, W] = size(image_original);
blur_impulse = fspecial('motion', 7, 0);
image_blurred = imfilter(image_original, blur_impulse, 'conv', 'circular');
noise_power = 1e-4;
randn('seed', 1);
noise = sqrt(noise_power) * randn(H, W);
image_noisy = image_blurred + noise;

figure; imshow(image_original, 'border', 'tight');
figure; imshow(image_blurred, 'border', 'tight');
figure; imshow(image_noisy, 'border', 'tight');

%% CLS restoration
alpha =  0.0001;  % try different values of alpha
image_cls_restored = cls_restoration(image_noisy, blur_impulse, alpha);
figure; imshow(image_cls_restored, 'border', 'tight');

%% computation of ISNR
% original vs blurred
snr(image_original,image_blurred) % 0.12
% original vs noisy
snr(image_original,image_noisy) % 0.11
% original vs cls restored with different alpha values
snr(image_original, image_cls_restored)
% {0.0001: -0.3,
% 0.001: -0.1,
% 0.01: -0.004,
% 0.1: 0.04,
% 1: 0.07,
% 10: 0.09,
% 100: 0.13}

%% end.