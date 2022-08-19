%% Image Compression with FFT
clear all, close all, clc

%%
A = imread('DATA/dog.jpg');
B = rgb2gray(A);
figure, imagesc(256-A)

%% FFT compression
figure
Bt=fft2(B);
Btsort = sort(abs(Bt(:)));  % Sort by magnitude

counter =1;
% Zero out all small coefficients and inverse transform
percentvec = [.99 .05 .01 .002];
for k=1:4
    subplot(2,2,counter)
    keep = percentvec(k);
    thresh = Btsort(floor((1-keep)*length(Btsort)));
    ind = abs(Bt)>thresh;
    Atlow = Bt.*ind;        % Threshold small indices
    Flow = log(abs(fftshift(Atlow))+1); % put FFT on log-scale
    
    % Plot Reconstruction
    Alow=uint8(ifft2(Atlow));
    imshow(256-Alow)
    title(['',num2str(keep*100),'%'],'FontSize',12)
    counter = counter +1;
    
    axis off
    %     print('-depsc2', '-loose', ['../figures/2DFFT_Compress',num2str(k)]);
%     print('-dpng', '-loose', ['../figures/2DFFT_Compress',num2str(k)]);
    
end

%%




%% end.