function mySpatiallyVaryingKernel(N)
%N=imread('../data/bird.jpg');
r2=size(N,1);
c2=size(N,2);
if r2>500
    M=zeros(r2/2,c2/2,3);
    for i=1:2:r2
        for j=1:2:c2
            M((i+1)/2,(j+1)/2,:)=N(i,j,:);
        end
    end
    M=uint8(M);
else
    M=N;
    M=uint8(M);
end
ForegroundMask = masking(M);    
masked=zeros(size(M)); % masked is the foreground image
unmasked=zeros(size(M)); %unmasked is the background image
r1=size(M,1);
c1=size(M,2);
for i=1:1:r1
    for j=1:1:c1
        if ForegroundMask(i,j)==255
           masked(i,j,:)=M(i,j,:);
           unmasked(i,j,:)=0;
        else
            masked(i,j,:)=0;
            unmasked(i,j,:)=M(i,j,:);
        end
    end
end
masked=uint8(masked);
unmasked=uint8(unmasked);




figure, subplot(2,2,1), imshow(M, imref2d(size(M))), colormap, colorbar;
title('Original');
J=mat2gray(ForegroundMask);
RI = imref2d(size(J));
subplot(2,2,2), imshow(J,RI), colormap, colorbar;
imwrite(J,'binarymask.png');
title('Binary Mask');
%J=mat2gray(res);
RI = imref2d(size(masked));
subplot(2,2,3), imshow(masked,RI), colormap, colorbar;
title('Foreground Masked Image');
imwrite(masked,'foregroundmaskedimage.png');
RI = imref2d(size(unmasked));
subplot(2,2,4), imshow(unmasked,RI), colormap, colorbar;
title('Background Masked Image');
imwrite(unmasked,'backgroundmaskedimage.png');
%suptitle('Masking');



radius=20;
padded=zeros(r1+2*radius,c1+2*radius,3);
paddedmask=zeros(r1+2*radius,c1+2*radius);
filter=zeros(r1,c1,3);
for i=1:1:r1
    for j=1:1:c1
       paddedmask(radius+i,radius+j)=ForegroundMask(i,j);
    end
end
%disp('done');
cont=zeros(size(M,1));
for i=1:1:r1
    for j=1:1:c1
        padded(radius+i,radius+j,:)=M(i,j,:);
    end
end
%disp('done');
for i=radius+1:1:r1+radius
    for j=radius+1:1:c1+radius
        if paddedmask(i,j) == 0
            r=radius;
            patch=padded(i-r:i+r,j-r:j+r,1);
            while (patch+paddedmask(i-r:i+r,j-r:j+r) ~= patch)
                if(r>0)
                    r=r-1;
                    patch=padded(i-r:i+r,j-r:j+r,1);
                else
                    break
                end
            end
            if(r>0)
                h_dummy = fspecial('disk',r);
                h=(h_dummy>0)/nnz(h_dummy);
                con=conv2(patch,h);
                filter(i-radius,j-radius,1)=con(r+1,r+1);
                if r1>350
                    patch2=padded(i-r:i+r,j-r:j+r,2);
                    con2=conv2(patch,h);
                    filter(i-radius,j-radius,2)=con2(r+1,r+1);
                else 
                    filter(i-radius,j-radius,2)=M(i-radius,j-radius,2);
                end
                %if r1<350
                    patch3=padded(i-r:i+r,j-r:j+r,3);
                    con3=conv2(patch,h);
                    filter(i-radius,j-radius,3)=con3(r+1,r+1);
                %else
                    %filter(i-radius,j-radius,3)=M(i-radius,j-radius,3);
                %end
            end
            cont(i-radius,j-radius)=r;
            
        else
            filter(i-radius,j-radius,:)=M(i-radius,j-radius,:);
            cont(i-radius,j-radius)=0;
        end
    end
disp(i);%to count how many rows are we done with    
end

cont=uint8(cont);
figure,contour(cont,10);
title('Contour Plot of r');
imwrite(cont,'binarymask.png');


h_dummy = fspecial('disk',radius/5);
h=(h_dummy>0)/nnz(h_dummy);
h=(h/max(max(h)))*255;
figure, subplot(2,3,1), imshow(h);
title('0.2d with intensitiy=0.0145');
h_dummy = fspecial('disk',2*radius/5);
h=(h_dummy>0)/nnz(h_dummy);
h=(h/max(max(h)))*255;
subplot(2,3,2), imshow(h);
title('0.4d with intensitiy=0.0041');
h_dummy = fspecial('disk',3*radius/5);
h=(h_dummy>0)/nnz(h_dummy);
h=(h/max(max(h)))*255;
subplot(2,3,3), imshow(h);
title('0.6d with intensitiy=0.0020');
h_dummy = fspecial('disk',4*radius/5);
h=(h_dummy>0)/nnz(h_dummy);
h=(h/max(max(h)))*255;
subplot(2,3,4), imshow(h);
title('0.8d with intensitiy=0.0011');
h_dummy = fspecial('disk',radius);
h=(h_dummy>0)/nnz(h_dummy);
h=(h/max(max(h)))*255;
subplot(2,3,5), imshow(h);
title('d with intensitiy=0.0007435');


filter=uint8(filter);

figure,imshow(filter),colormap, colorbar; %to show the final image
title('Blurred Image');
imwrite(filter,'blurredimage.png');

            

