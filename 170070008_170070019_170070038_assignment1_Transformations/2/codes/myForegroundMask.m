function myForegroundMask(M, t)
%M=imread("statue.png");
%{
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
%imagesc (single (phantom)); % phantom is a popular test image
colormap (myColorScale);
colorbar
&}
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%}
r1=size(M,1);
c1=size(M,2);
disp(r1);
disp(c1);
%disp(M);
threshold=t;
mask=zeros(r1,c1);
res = mask;
for i=1:1:r1
    for j=1:1:c1
        if M(i,j)>threshold
            mask(i,j)=255;
            res(i,j) = M(i,j);
        end
    end
end
%binary
figure, subplot(1,3,1), imshow(M, imref2d(size(M))), colormap, colorbar;
title('Original');
J=mat2gray(mask);
RI = imref2d(size(J));
subplot(1,3,2), imshow(J,RI), colormap, colorbar;
imwrite(J,'binarymask.png');
title('Binary Mask');
J=mat2gray(res);
RI = imref2d(size(J));
subplot(1,3,3), imshow(J,RI), colormap, colorbar;
title('Masked Image');
imwrite(J,'maskedimage.png');
suptitle('Foreground Masking');
end




