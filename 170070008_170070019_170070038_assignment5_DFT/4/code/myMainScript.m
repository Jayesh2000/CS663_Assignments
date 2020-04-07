%% MyMainScript

tic;
%% Your code here
X=imread("../data/barbara256.png");
%imshow(X);
%disp(size(X));
%X=padarray(X,[size(X,1),size(X,2)],0,'both');
%Parameters
D=80;
sig=80;
%Getting the fourier transform
F=fftshift(fft2(X));
F1=F;
F=log(abs(F));
LowPassFilter=ones(size(X,1),size(X,2));
%figure,imshow(mat2gray(abs(F)));
%Now we are going to do low pass filtering
x1=double(size(F,1)+1)/2;
y1=double(size(F,2)+1)/2;
for i=[1:1:size(F,1)]
    for j=[1:1:size(F,2)]
        if ((i-x1)^2+(j-y1)^2>D^2)
            F1(i,j)=0;
            LowPassFilter(i,j)=0;
        end
    end
end
%Displaying the image
%figure,imshow(mat2gray(log(abs(LowPassFilter))));
%figure,imshow(log(abs(F1)));
Out1=ifft2(ifftshift(F1));
%figure,imshow(mat2gray(abs(Out1)));

%Now we are going to do Gaussian filtering
filt=fspecial('gaussian',size(X,1),sig);
F2=F;
x1=double(size(F,1)+1)/2;
y1=double(size(F,2)+1)/2;
F1=F1.*filt;
%Displaying the image
figure,imshow(log(70000*abs(filt)));
title("Gaussian filter frequency response");
Out1=ifft2(ifftshift(F1));
figure,imshow(mat2gray(abs(Out1)));
title("output image for cut-ff frequency=80 ");

toc;
