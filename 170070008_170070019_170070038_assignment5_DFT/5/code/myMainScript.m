%% MyMainScript
tic;
%% Your code here
im = imread('../data/barbara256-part.png');
im = double(im);
im1 = im + randn(size(im))*20;

%%Part-1
im2 = myPCADenoising1(im1);
RMSE_1 = norm((im2-im))/norm(im);
disp('RMSE is found to be :');
disp(RMSE_1);
figure,imshow(uint8(im));
title('PCA Global Denoising: barbara256-part Test Image');
figure,imshow(uint8(im1));
title('PCA Global Denoising: Noisy Image');
figure,imshow(uint8(im2));
title('PCA Global Denoising: Denoised Image');

%%Part-2
im3 = myPCADenoising2(im1,400);
RMSE_2 = norm((im3-im))/norm(im);
disp('RMSE is found to be :');
disp(RMSE_2);
figure,imshow(uint8(im));
title('PCA Window Denoising: barbara256-part Test Image');
figure,imshow(uint8(im1));
title('PCA Window Denoising: Noisy Image');
figure,imshow(uint8(im3));
title('PCA Window Denoising: Denoised Image');

%%Part-2-b
im_b = imread('../data/stream.png');
im_b = double(im_b);
im_b = imresize(im_b,0.5);
im1_b = im_b + randn(size(im_b))*20;
im3_b = myPCADenoising2(im1_b,400);
RMSE_2_b = norm((im3_b-im_b))/norm(im_b);
disp('RMSE is found to be :');
disp(RMSE_2_b);
figure,imshow(uint8(im_b));
title('PCA Window Denoising: stream256-part Test Image');
figure,imshow(uint8(im1_b));
title('PCA Window Denoising: Noisy Image');
figure,imshow(uint8(im3_b));
title('PCA Window Denoising: Denoised Image');
%Since actual image was taking a lot of time, it was down-sized to 256x256
%image

%%Part-3
sigd=0.8;
sigi=45;
im4=myBilateralFiltering(im1,im,sigd,sigi);
RMSE_3 = norm((im4-im))/norm(im);
disp('RMSE is found to be :');
disp(RMSE_3);
figure,imshow(uint8(im));
title('Bilateral filtering: barbara256-part Test Image');
figure,imshow(uint8(im1));
title('Bilateral filtering: Noisy Image');
figure,imshow(im4);
title('Bilateral filtering: Denoised Image');

%%We see that in Bilateral filtering the results are not that good as
%%obtained in PCA Denoising which is done using the information of other
%%patches. Moreover filtering operation does the smoothning function more
%%than denoising function.
%%Since we use information from similar patches in PCA Denoising therefore
%%we can get information about the texture from the similar patch which
%%helps in denoising.

%%Part-4-a
image_1_a = poissrnd(im);
image_1 = image_1_a + 0.375;
image_1 = sqrt(image_1);
image_2 = myPCADenoising2(image_1,0.0625);
image_2 = image_2.^2;
image_2 = image_2 - 0.375;
RMSE_4_a = norm((image_2-im))/norm(im);
disp('RMSE is found to be :');
disp(RMSE_4_a);
figure,imshow(uint8(image_1_a));
title('Sufficient Exposure time:  Noisy Image');
figure,imshow(uint8(image_2));
title('Sufficient Exposure time:  Denoised Image');


%%Part-4-b
image_3_a = poissrnd(im/20);
image_3 = image_3_a + 0.375;
image_3 = sqrt(image_3);
image_4 = myPCADenoising2(image_3,0.0625);
image_4 = image_4.^2;
image_4 = image_4 - 0.375;
RMSE_4_b = norm((image_4-(im/20)))/norm(im/20);
disp('RMSE is found to be :');
disp(RMSE_4_b);
figure,imshow(uint8(image_3_a));
title('Low Exposure time: Noisy Image');
figure,imshow(uint8(image_4));
title('Low Exposure time: Denoised Image');
%Since the scaling factor is 20, the output image is very dark!! But the
%image shall be visible when looked closely.

%%Part-5
%%If we clamp the values of denoised image from (0,255) in PCA Denoising
%%function then we are scaling the values and then performing the denoising
%%which ultimately results in scaled down values of all the pixels and
%%hence the RMSE value will be large. Since we do not know the maximum
%%value (after scaling) of the noised image we can not upscale it thus it will be dimmed
%%image.

toc;
