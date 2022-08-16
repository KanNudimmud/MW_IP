%% SVD Image Compression
clear all, close all, clc
%% Load image
A = imread("DATA\dog.jpg");

% Convert to double for computations
X = double(rgb2gray(A));

nx = size(X,1); ny = size(X,2);

% Visualize
subplot(221)
imagesc(X),axis off
colormap gray
title('Original')
set(gcf,'Position',[1400 100 1200 1600])

%% Compression
% Compute SVD 
[U,S,V] = svd(X,'econ');

plotind = 2;
for r=[5 20 100] % Truncation value
    Xapprox = U(:,1:r)*S(1:r,1:r)*V(:,1:r)'; % Approx. image
    subplot(2,2,plotind), plotind = plotind+1;
    imagesc(Xapprox), axis off, colormap gray;
    title(['r=',num2str(r,'%d'),', ',num2str(100*r*(nx+ny)/(nx*ny),'%2.2f'),'% storage']);
set(gcf,'Position',[100 100 550 400])
end

%% Singular Values
figure, subplot(1,2,1)
semilogy(diag(S),'k','LineWidth',1.2), grid on
xlabel('r')
ylabel('Singular value, \sigma_r')
xlim([-50 1550])
subplot(1,2,2)
plot(cumsum(diag(S))/sum(diag(S)),'k','LineWidth',1.2), grid on
xlabel('r')
ylabel('Cumulative Energy')
xlim([-50 1550]); ylim([0 1.1])
set(gcf,'Position',[100 100 550 240])

%% Correlation matrices
XXt = X*X';
XtX = X'*X;
subplot(1,2,1)
imagesc(XtX);
axis off, colormap gray
subplot(1,2,2)
imagesc(XXt);
axis off, colormap gray

%% end.