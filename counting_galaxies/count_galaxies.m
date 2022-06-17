%% Count the number of galaxies in the picture
% import the picture
space = imread('galaxies.jpg');
space = mean(space,3);

figure(1)
imagesc(space)
colormap hot

%% threshold
% pick a threshold based on the pixel intensity distribution
hist(space(:),300)

% for example...
thresh = 50;

figure(2)
highmap = space;
highmap(space>thresh) = 1000;

imagesc(highmap)
set(gca,'clim',[0 255])
colormap hot

%% find islands
% threshold binarized image
islands = bwconncomp( space>thresh );

% would be nice to know the number of pixels in each cluster...
islands.PixelsPerCluster = cellfun(@length,islands.PixelIdxList);

% histogram of size (pixel count)
figure(3)
hist(islands.PixelsPerCluster,200)

% n.b., galaxies are HUGE; filter out small clusters
minGalaxySize = 20; % contiguous pixels
islands.PixelIdxList = islands.PixelIdxList(islands.PixelsPerCluster>minGalaxySize);

% update
islands.PixelsPerCluster = cellfun(@length,islands.PixelIdxList);
islands.NumObjects = length(islands.PixelIdxList);

% make the galaxies stand out from the "noise"
highspace = space;
for ii=1:islands.NumObjects
    highspace(islands.PixelIdxList{ii}) = 1000;
end

figure(4)
imagesc(highspace)
set(gca,'clim',[0 255])
colormap hot

%% number of galaxies as a function of threshold

threshs = round(linspace(20,200,50));
numGalaxies = zeros(size(threshs));

minGalaxySize = 20; % contiguous pixels

for threshi=1:length(threshs)
    % threshold
    islands = bwconncomp( space>threshs(threshi) );
    islands.PixelsPerCluster = cellfun(@length,islands.PixelIdxList);
    
    % count
    numGalaxies(threshi) = numel(islands.PixelIdxList(islands.PixelsPerCluster>minGalaxySize));
    
end

figure(5)
plot(threshs,numGalaxies,'ks-','markersize',10,'markerfacecolor','w')
xlabel('Threshold (num. pixels)')
ylabel('Number of galaxies')

%% end.