function myCLAHE(M, window_size, epsilon)
%M=imread("retina.png");
%hist = zeros(256, size(M,3));
%window_size = 25;
%epsilon = 0.05;
factor = (window_size - 1)/2;
hist_window = zeros(size(M));
for i=1:1:size(M,3)
      for j = 1:1:size(M,1)
        for k = 1:1:size(M,2)
           hist_window(j,k,i) = funcHE(M,j,k,i,factor, epsilon);           
        end
      end
end
figure,subplot(2,1,1), imshow(mat2gray(M)), colormap, colorbar;
title('Original Image');
subplot(2,1,2), imshow(mat2gray(hist_window)), colormap, colorbar;
title('CLAHE Image');
suptitle('CLAHE');
end
