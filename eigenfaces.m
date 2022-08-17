%% Eigenfaces
clear all, close all, clc
%% Load images
load DATA/allFaces.mat % Yale B Dataset

allPersons = zeros(n*6,m*6);
count = 1;
for i=1:6
    for j=1:6
        allPersons(1+(i-1)*n:i*n,1+(j-1)*m:j*m) ...
            = reshape(faces(:,1+sum(nfaces(1:count-1))),n,m);
        count = count + 1;
    end
end

figure(1), axes('position',[0  0  1  1]), axis off
imagesc(allPersons), colormap gray

figure(2),axes('Position',[0 0 1 1]), axis off
for person = 1:length(nfaces)
    subset = faces(:,1+sum(nfaces(1:person-1)):sum(nfaces(1:person)));
    allFaces = zeros(n*8,m*8);
    
    count = 1;
    for i=1:8
        for j=1:8
            if(count<=nfaces(person)) 
                allFaces(1+(i-1)*n:i*n,1+(j-1)*m:j*m) ...
                    = reshape(subset(:,count),n,m);
                count = count + 1;
            end
        end
    end
    
    imagesc(allFaces), colormap gray    
end

%% Compute eigenfaces
% We use the first 36 people for training data
trainingFaces = faces(:,1:sum(nfaces(1:36)));
avgFace = mean(trainingFaces,2);  % size n*m by 1;

% compute eigenfaces on mean-subtracted training data
X = trainingFaces-avgFace*ones(1,size(trainingFaces,2));
[U,S,V] = svd(X,'econ');

% Plot average face
figure, axes('position',[0  0  1  1]), axis off
imagesc(reshape(avgFace,n,m)), colormap gray

% Plot eigenfaces
EigenDaces = zeros(n*8,m*8);
count = 1;
for i=1:8
    for j=1:8
        EigenFaces(1+(i-1)*n:i*n,1+(j-1)*m:j*m)...
            = reshape(U(:,count),n,m);
        count = count +1;
    end
end
figure, axes('position',[0  0  1  1]), axis off
imagesc(EigenFaces), colormap gray

%% Show eigenface reconstruction of image that was omitted from test set

testFace = faces(:,1+sum(nfaces(1:36))); % first face of person 37

figure,
subplot(2,4,1),axis off
imagesc(reshape(testFace,n,m)), colormap gray
count = 1;

testFaceMS = testFace - avgFace;
for r=[25 50 100 200 400 800 1600]
    count = count +1;
    subplot(2,4,count)
    reconFace = avgFace + (U(:,1:r)*(U(:,1:r)'*testFaceMS));
    imagesc(reshape(reconFace,n,m)), colormap gray
    title(['r=',num2str(r,'%d')]);
    pause(0.1)
end

%% Project person 2 and 7 onto PC5 and PC6

P1num = 2;  % person number 2
P2num = 7;  % person number 7
P1 = faces(:,1+sum(nfaces(1:P1num-1)):sum(nfaces(1:P1num)));
P2 = faces(:,1+sum(nfaces(1:P2num-1)):sum(nfaces(1:P2num)));
P1 = P1 - avgFace*ones(1,size(P1,2));
P2 = P2 - avgFace*ones(1,size(P2,2));

figure 
subplot(1,2,1), imagesc(reshape(P1(:,1),n,m)); colormap gray, axis off
subplot(1,2,2), imagesc(reshape(P2(:,1),n,m)); colormap gray, axis off

% project onto PCA modes 5 and 6
PCAmodes = [5 6];
PCACoordsP1 = U(:,PCAmodes)'*P1;
PCACoordsP2 = U(:,PCAmodes)'*P2;

figure
plot(PCACoordsP1(1,:),PCACoordsP1(2,:),'kd','MarkerFaceColor','k')
axis([-4000 4000 -4000 4000]), hold on, grid on
plot(PCACoordsP2(1,:),PCACoordsP2(2,:),'r^','MarkerFaceColor','r')
set(gca,'XTick',[0],'YTick',[0]);
legend('Person 1','Person 2')

%% end.