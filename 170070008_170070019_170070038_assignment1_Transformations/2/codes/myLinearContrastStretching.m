function myLinearContrastStretching(M)
%M=imread("barBarasmall.png");
%{
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
%imagesc (single (phantom)); % phantom is a popular test image
colormap (myColorScale);
colorbar
%}
r1=size(M,1);
c1=size(M,2);
num=size(M,3);
y=zeros(r1,c1,num);
disp(num);
for i=1:1:num
    y(:,:,i)=LinStretch(M(:,:,i));
end
%y=LinStretch(M);
%disp(max(y,[],'all'));
    J = mat2gray(y);
    figure, subplot(1,2,2), imshow(J, imref2d(size(J))), colormap, colorbar;
    title('Contrast Stretched Image');
    subplot(1,2,1), imshow(M,imref2d(size(M))),  colormap, colorbar;
    title('Original Image');
    suptitle('Linear Contrast Stretching');
end








