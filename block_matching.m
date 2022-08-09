%% Block matching motion estimation between two consecutive video frames
%% Load video frames
frame_1 = imread('frame_1.jpg');
frame_2 = imread('frame_2.jpg');

I_1 = im2double(frame_1);
I_2 = im2double(frame_2);

%% Define target block
B_target = I_2(65:96,81:112); % 32x32

%% Block matching with mean absolute error criterion
mae0 = 100;
for i=1:size(I_1,1)-32
    for j=1:size(I_1,2)-32
        error = B_target - I_1(i:i+31,j:j+31);
        abserr = abs(error);
        mae1 = sum(sum(abserr)) / (32*32);
        if mae0 > mae1
            mae0 = mae1;
            ans  = [i, j, mae0]; 
        end
    end
end

ans

%% Visualization
figure,
subplot(221)
imshow(I_1),title('Frame 1')

subplot(222)
imshow(I_2),title('Frame 2')

subplot(223)
imshow(B_target),title('Target Block')

subplot(224)
imshow(I_1(ans(1):ans(1)+31, ans(2):ans(2)+31))
title('Frame 1 with the Matched Block')

%% end.