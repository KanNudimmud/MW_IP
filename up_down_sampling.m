%% down and up sampling
clear all, close all, clc
%% Load the image
building = imread("building.jpg");

% Convert to double
buildingD = im2double(building);

%% Create a low-pass filter
filter = ones(3,3) * 1/9;

% Perform the filter
buildingDf = imfilter(buildingD,filter,'replicate');

%% Down-Sampling
down_sampled = buildingDf(1:2:end, 1:2:end); % 180x240

%% Create low-resolution image
array = zeros(359,479);
for i=1:size(array,1)
    for j=1:size(array,2)
        if sum(rem([i j],2))==2 
            array(i,j) = down_sampled((i+1)/2,(j+1)/2);
        end
    end
end

%% Filter the previos result
filter2 = [0.25, 0.5, 0.25;
    0.5, 1, 0.5;
    0.25, 0.5, 0.25];

arrayf2 =imfilter(array,filter2);
% bilenear interpolation to obtain the up-sampled image

%% Compute PSNR
psnr(arrayf2,buildingD)

%% Visualizations
figure,
subplot(231)
imshow(building), title('Original Image')

subplot(232)
imshow(buildingD), title('Doubled Image')

subplot(233)
imshow(buildingDf), title('Low-pass Filtered Image')

subplot(234)
imshow(down_sampled), title('Down-Sampled Image')

subplot(235)
imshow(array), title('Low-resolution Image')

subplot(236)
imshow(arrayf2), title('Up-Sampled Image')


%% end.