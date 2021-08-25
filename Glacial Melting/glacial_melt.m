%% Analyzing Glacial Melt
% Landsat satellite images of Bear Glacier are obtained from USGS-National Land Imaging Program
%% Extracting image file information
% Extrack the meta data
info1980 = imfinfo("bearGlacier1980.png");
info2011 = imfinfo("bearGlacier2011.png");

% Be sure of creation time of images
taken1980 = info1980.CreationTime;
taken2011 = info2011.CreationTime;

% Check color type of images
type1980 = info1980.ColorType;
type2011 = info2011.ColorType;

%% View images
% Import image of Bear Glacier in 1980
[glacier1980,map1980] = imread("bearGlacier1980.png");

% Display image
figure(1)
subplot(121)
imshow(glacier1980,map1980)
title("Bear Glacier in 1980")

% Import and display image of Bear Glacier in 2011 
[glacier2011,map2011] = imread("bearGlacier2011.png");
figure(1)
subplot(122)
imshow(glacier2011,map2011)
title("Bear Glacier in 2011")

% Convert images to grayscale
gs1980 = ind2gray(glacier1980,map1980);
gs2011 = ind2gray(glacier2011,map2011);

% Display grayscaled images
figure(2)
imshowpair(gs1980,gs2011,"montage")
title("Bear Glacier Comparison between 1980 & 2011")

% Since images are indexed, they have 20 columns which can be reduced
% for example:
[ind1980,m8_1980] = imapprox(glacier1980,map1980,8);
figure(3)
imshow(ind1980,m8_1980)
title("Bear Glacier in 1980 with 8 columns")

% Save grayscaled images
imwrite(gs1980,"gs1980.png")
imwrite(gs2011,"gs2011.png")

%% Difference between 1980 & 2011
% Calculate the difference 
diffIce = gs1980 - gs2011;

% Visualize the difference
figure(4)
subplot(121)
imshow(diffIce,[])
title('Difference between 1980 & 2011')

% Interpretation:
% Difference should be between -255 and 255 but, uint8
% values can not be negative so, all negative numbers becomes 0.
% While gs1980 - gs2011, 0 (dark) means there was more ice in 2011.
% However, small differences give the same result.

% To get the proper range [-255,255], image should be converted to double.
d1980 = im2double(gs1980);
d2011 = im2double(gs2011);

% Calculate the difference again
diffIce = d1980 - d2011;

% Rescale the values for difference
diffIce = rescale(diffIce);

% Display the doubled and rescaled difference
figure(4)
subplot(122)
imshow(diffIce)
title('Doubled and Rescaled Difference between 1980 & 2011')

% Show doubled images in pair
figure(5)
imshowpair(d1980,d2011)
title('Where there was more glacier in 1980 is indicated as green')

%% Thresholding
% Create  binary images and display them
ice1980 = diffIce>.7;
ice2011 = diffIce<.3;

figure(6)
subplot(121)
imshow(ice1980)
title('Where the rescaled difference is greater than 0.7')

subplot(122)
imshow(ice2011)
title('Where the rescaled difference is less than 0.3')

% Calculate the percentage of ice loss
melt = nnz(ice1980) / numel(ice1980) * 100;

%% Alternative Solution for Comparison 
% Binarize images
bw1980 = imbinarize(gs1980);
bw2011 = imbinarize(gs2011);

% Display them in a pair
figure(7)
imshowpair(bw1980,bw2011)

% Calculate the glacial melt (it gives more accurate answer)
melt = (nnz(bw2011)-nnz(bw1980)) / nnz(bw1980) * 100;

%% Segmentation
% Apply a mask to the image to indicate glacier 
glacier = imoverlay(gs1980,bw1980,'g');

% Apply a mask to the image to indicate land and sea 
lSea = imoverlay(gs1980,~bw1980,'g');

% Apply a mask to the image to indicate loss glacier
loss = imoverlay(gs2011,~bw1980,'g');

% Visualize all masks
figure(8)
subplot(131)
imshow(glacier), title('Glacier is indicated in 1980')

subplot(132)
imshow(lSea), title('Land and sea are indicated in 1980')

subplot(133)
imshow(loss), title('Loss of glacier between 1980-2011 are indicated as dark')

%% end