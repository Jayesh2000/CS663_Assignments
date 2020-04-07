function myShrinkImageByFactorD(M)
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
%imagesc (single (phantom)); % phantom is a popular test image
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

%M=imread("circles_concentric.png");
r1=size(M,1);
disp(r1);
d=2;
r2=r1/d;
c2=r2;
res=zeros(r2,c2);

for i=1:1:r2
    for j=1:1:c2
        res(i,j)=M(d*i,d*j);        
    end
end

J=mat2gray(res);
RI = imref2d(size(J));
subplot(1,2,2), imshow(J,RI), colormap, colorbar;
title('Shrink by 2');
subplot(1,2,1), imshow(M, imref2d(size(M))), colormap, colorbar;
title('Original');
suptitle('Shrinking Image by Factor of 2');
%figure, image(J), colormap, colorbar;
d=3;
r2=floor(r1/d);
c2=r2;
res=zeros(r2,c2);

for i=1:1:r2
    for j=1:1:c2
        res(i,j)=M(d*i,d*j);        
    end
end

J=mat2gray(res);
RI = imref2d(size(J));
figure, subplot(1,2,2), imshow(J,RI), colormap, colorbar;
title('Shrink by 3');
subplot(1,2,1), imshow(M, imref2d(size(M))), colormap, colorbar;
title('Original');
suptitle('Shrinking Image by Factor of 3');
%figure, image(res), colormap, colorbar;
end


