function myNearestNeighborInterpolation(M)
%M=imread("barbaraSmall.png");
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
%imagesc (single (phantom)); % phantom is a popular test image
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
r1=size(M,1);
disp(r1);
c1=size(M,2);
r2=3*r1-2;
c2=2*c1-1;
res=zeros(r2,c2);

disp(c1);

for i=1:1:r1
    for j=1:1:c1
        res(3*i-2,2*j-1)=M(i,j);        
    end
end

%disp(res);

%Doing nearest neighbour interpolation of the rows

for i=1:1:r2-1
    for j=1:2:c2
        if mod(i,3) == 2
            res(i,j)=res(i-1,j);
        end
        if mod(i,3) == 0
            res(i,j)=res(i+1,j);
        end        
    end
end

%Doing bilinear interpolation of the columns
for i=1:1:r2
    for j=2:2:c2
        res(i,j)=res(i,j-1);       
    end
end

J=mat2gray(res);
RI = imref2d(size(J));
figure, subplot(1,2,2), imshow(J,RI), colormap, colorbar;
title('Nearest Neighbour Interpolated');
subplot(1,2,1), imshow(M, imref2d(size(M))), colormap, colorbar;
title('Original');
suptitle('Nearest Neighbour Interpolation');
end





