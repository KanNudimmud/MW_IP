%% Lossless Compression
clear all, close all, clc
%% Load Image
img  = imread('Cameraman256.bmp');
imgG = im2gray(img);

%%
% Create discrete memoryless source(DMS)
for i=1:256
    DMS(i,1)=i-1;
    DMS(i,2)=0;
end

% Find occurences of pixel intensities (like histogram), 
% and add counts to DMS
for i = 1:256
    for j = 1:256
        for k = 1:256
            if imgG(i,j) == DMS(k,1)
                DMS(k,2) = DMS(k,2)+1;
            end
        end
    end
end

% Determine pixel counts
sum = size(imgG,1)*size(imgG,2);

% Calculate probablities
for i = 1:256
    prob(i) = DMS(i,2)/sum;
end

% Calculate entropy
ans=0;
for i = 1:256
    entropy(i) = -1 * prob(i) * log2(prob(i));
    ans = ans + entropy(i);
end
ans

%% end.