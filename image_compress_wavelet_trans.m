%% Image Compression with Wavelet Transform
clear all, close all, clc

%%
A = imread('DATA/dog.jpg');
B = rgb2gray(A);

%% Wavelet decomposition (2 level)
n = 2; w = 'db1'; [C,S] = wavedec2(B,n,w);

% LEVEL 1
A1 = appcoef2(C,S,w,1); % Approximation
[H1 V1 D1] = detcoef2('a',C,S,1); % Details
A1 = wcodemat(A1,128);
H1 = wcodemat(H1,128);
V1 = wcodemat(V1,128);
D1 = wcodemat(D1,128);

% LEVEL 2
A2 = appcoef2(C,S,w,2); % Approximation
[H2 V2 D2] = detcoef2('a',C,S,2); % Details
A2 = wcodemat(A2,128);
H2 = wcodemat(H2,128);
V2 = wcodemat(V2,128);
D2 = wcodemat(D2,128);

dec2 = [A2 H2; V2 D2];
dec1 = [imresize(dec2,size(H1)) H1 ; V1 D1];
image(dec1);
colormap gray
axis off, axis tight

%% Wavelet Compression
[C,S] = wavedec2(B,4,'db1');
Csort = sort(abs(C(:))); % Sort by magnitude

figure
counter = 1;
for keep =  [.1 .05 .01 .005]
    subplot(2,2,counter)
    thresh = Csort(floor((1-keep)*length(Csort)));
    ind = abs(C)>thresh;
    Cfilt = C.*ind;      % Threshold small indices
    
    % Plot Reconstruction
    Arecon=uint8(waverec2(Cfilt,S,'db1'));
    imagesc(uint8(Arecon))
    title(['',num2str(keep*100),'%'],'FontSize',12)
    colormap gray
    counter = counter +1;
end



%% end.