%% Pseudo Coloring
clear all, close all, clc
%% Intensity Slicing Program (discrete shading)
[filename,pathname] = uigetfile('*.*','Select grayscale image');
filewithpath        = strcat(pathname,filename);

img = imread(filewithpath);

[r,c] = size(img);
R     = uint8(zeros(r,c));
G     = uint8(zeros(r,c));
B     = uint8(zeros(r,c));

nos      = input('Enter number of slices: ');
color    = zeros(nos,3);
interval = zeros(nos,2);

for i=1:nos
    interval(i,:) = input('Enter intensity interval: ');
    color(i,:)    = uint8(255*uisetcolor('Select color for pseudo coloring'));
end

for s=1:nos
    slice = interval(s,:);
    LL    = slice(1);
    UL    = slice(2);
    rgb   = color(s,:);
    red=rgb(1); green = rgb(2); blue=rgb(3);
    for i=1:r
        for j=1:c
            if img(i,j)>=LL && img(i,j)<=UL
                R(i,j)=red;
                G(i,j)=green;
                B(i,j)=blue;
            end
        end
    end
end

imgc = cat(3,R,G,B);
imshow(imgc)
title('Pseudo Color Image')

%% Intensity Slicing Program (smooth shading)
[filename,pathname] = uigetfile('*.*','Select grayscale image');
filewithpath        = strcat(pathname,filename);

img = imread(filewithpath);

[r,c] = size(img);
R     = uint8(zeros(r,c));
G     = uint8(zeros(r,c));
B     = uint8(zeros(r,c));

coltype = input('Enter choice of colormap as string, for example jet: ');

colmap = uint8(255*coltype);
if (length(colmap)~=256)
    colmap = imresize(colmap,[256,3]);
end

for i=1:r
    for j=1:c
        R(i,j)=colmap(img(i,j)+1,1);
        G(i,j)=colmap(img(i,j)+1,2);
        B(i,j)=colmap(img(i,j)+1,3);
      
    end
end

imgc = cat(3,R,G,B);
imshow(imgc)
title('Pseudo Color Image')

%% Color Transformation
[filename,pathname] = uigetfile('*.*','Select grayscale image');
filewithpath        = strcat(pathname,filename);

img = imread(filewithpath);

[r,c] = size(img);
R     = uint8(zeros(r,c));
G     = uint8(zeros(r,c));
B     = uint8(zeros(r,c));

theta = linspace(0,4*pi,256);

Rv = 255 * abs(sin(theta)+pi/2);
Gv = 255 * abs(sin(theta)-(pi/3));
Bv = 255 * abs(sin(theta+(pi)/2));

for i=1:r
    for j=1:c
        R(i,j)=Rv(img(i,j)+1);
        G(i,j)=Gv(img(i,j)+1);
        B(i,j)=Bv(img(i,j)+1);
      
    end
end

imgc = cat(3,uint8(R),uint8(G),uint8(B));
imshow(imgc)
title('Pseudo Color Image')

%% end.