%% Segmentation due to Colour
% Image is obtained from :
% https://craftofcoding.wordpress.com/2019/04/03/computer-vision-ai-and-the-art-of-fruit-picking/
%% Thresholding Color Planes
% Load the data
sb = imread("strawberry.jpg");
figure(1)
imshow(sb)

% Extract red and green color planes
[r,g] = imsplit(sb);
figure(2)
imshowpair(r,g,"montage")

% Binarize image on the red plane
Bsb = imbinarize(r);
figure(3)
subplot(311)
imshow(Bsb)
title("Binarized Strawberries on Red Plane")

% Create a mask for red areas
rMask = r > 150;
figure(3)
subplot(312)
imshow(rMask)
title("Masked and Binarized Strawberries on Red Plane")

% Create a mask for non-green areas
gMask = g < 50;
figure(3)
subplot(313)
imshow(gMask)
title("Masked and Binarized Strawberries on Green Plane")

% Combine both masks
rgMask = (r > 150) & (g < 50);
figure(4), subplot(121)
imshow(rgMask)
title('Masked by Red and Green')

% Another approach
diffMask = (r-g) > 50;
figure(4), subplot(122)
imshow(diffMask)
title('Mask by difference of Red and Green')

%% Segmentation with Lab Color Space
% Convert the image from RGB to Lab
sbLab = rgb2lab(sb);

% Extract first channel which contains brigthness from black to white
L = sbLab(:,:,1); % Luminance
figure(5), subplot(121) 
histogram(L) % for pixel intensities
title('Pixel Intensity of Luminance Plane')

% Extract second channel which is a measurement of hue from green to red
g2r = sbLab(:,:,2);

% Extract third channel which is a measurement of hue from blue to yellow
b2y = sbLab(:,:,3);

% Display all planes
figure(6)
subplot(311)
imshow(L,[]),title('Strawberries on Luminal Plane')

subplot(312)
imshow(g2r,[]),title('Strawberries on a* Plane')

subplot(313)
imshow(b2y,[]),title('Strawberries on b* Plane')

% As seen, a* plane gives the best result
% To determine a threshold view the pixel intensity
figure(5), subplot(122)
histogram(g2r)
title('Pixel Intensity of a* Plane')

% Create a mask according to histogram
labMask = g2r > 17;
figure(8), imshow(labMask)
title('Masked Strawberries on a* Plane ')

%% end