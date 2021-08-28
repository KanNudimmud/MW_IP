%% Analyzing Texture
% Images are obtained from:
% https://www.travelbutlers.com/safari/wildlife-guide/zebra.asp
% https://blog.csiro.au/patterns-nature-zebra-stripes/
%% Neighborhood for Texture
% Load the data 
zebras = imread('zebras.jpg');

% Convert to gray scale
zebras = im2gray(zebras);

% Display gray scaled original image
figure(1), subplot(311)
imshow(zebras)
title("Original Image")

% Apply a range filter
zebrasRF = rangefilt(zebras); % default neighborhood is 3-by-3 square
figure(2), subplot(131)
imshow(zebrasRF)
title('3x3 Neighborhood')

% Try different neighborhood size
nhood      = true(11); 
zebrasRF_11 = rangefilt(zebras,nhood);

nhood_rec    = true(13,17);
zebrasRF_rec = rangefilt(zebras,nhood_rec);

% Display range filters together
figure(2), subplot(132)
imshow(zebrasRF_7)
title('11x11 Neighborhood')

figure(2), subplot(133)
imshow(zebrasRF_rec)
title('13x17 Neighborhood')

% Binarize the best result 
zebrasB = imbinarize(zebrasRF_rec);
figure(1), subplot(312)
imshow(zebrasB)
title('Range Filtered Image')

% Apply entropy filter
nhood_ent = true(37,27);
zebrasEnt = entropyfilt(zebras,nhood_ent);

% Rescale filtered image
zebrasEnt = rescale(zebrasEnt);

% Smooth the rescaled image
smooth_z = medfilt2(zebrasEnt,[7 7]);

% Binarize smoothed image
zebrasEntB = imbinarize(smooth_z);
figure(1), subplot(313)
imshow(zebrasEntB)
title("Entropy Filtered Image")

%% Detecting Horizontal Pattern
% Load the image
stripes = imread("zebra_stripes.jpg");

% Convert the image to 2-D
stripes = stripes(:,:,1);

figure(3)
imshow(stripes)
title("Zebra Stripes")

% Create an offset vector ([Vertical Horizontal])
right = [0 33]; % 33th pixel to right

% Calculate gray-level co-occurence matrix
glcom_r = graycomatrix(stripes,"Offset",right);

% Statistics about the matrix
stats_r = graycoprops(glcom_r);

%% Detecting Vertical Pattern
% Create an offset
above = [-33 0];

% Calculate gray-level co-occurence matrix
glcom_a = graycomatrix(stripes,"Offset",above);

% Statistics about the matrix
stats_a = graycoprops(glcom_a);

% Apply same procedure for severel offsets
aboves = [-3 0; -12 0; -21 0; -33 0];

glcom_as = graycomatrix(stripes,"Offset",aboves);

stats_as = graycoprops(glcom_as);

% Interpretation:
% Statistics and image is relavent. Correletion in vertical pattern is
% higher than horizontal pattern,and vice versa for contrast values
% as seen in the image.
%% end