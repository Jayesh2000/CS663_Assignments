%% MyMainScript

tic;
%% Your code here
S=load("../data/image_low_frequency_noise.mat");
X=S.Z;
disp(size(X));

F=fftshift(fft2(X));
Fdum=F;
F=log(abs(F));
disp(size(F));
imshow(mat2gray(X));
title("Original Image");
figure,imshow(mat2gray(F));
title("Fourier Transform with log magnitude");
%Points for the centres of the notch reject filter
x1=118;
y1=123;
x2=138;
y2=133;
r=5;%Radius of the notch reject filter
for i=[x1-r:1:x2+r]
    for j=[y1-r:1:y2+r]
        if ((x1-i)^2+(y1-j)^2<=r^2)
            Fdum(i,j)=0;
            F(i,j)=0;
        end
        if ((x2-i)^2+(y2-j)^2<=r^2)
            Fdum(i,j)=0;
            F(i,j)=0;
        end
    end
end
figure,imshow(mat2gray(F));
title("Log Magnitude Fourier Transform after Notch Reject Filter");
%title();
X1=ifft2(ifftshift(Fdum));
max1=max(abs(X1),[],'all');
min1=min(abs(X1),[],'all');
disp(max1);
Out2=abs(X1).*(double(254)/double(max1-min1));
disp(max(abs(Out2),[],'all'));
%disp(Out2);
figure,imshow(uint8(X1));
title("Image after Notch Reject Filter");


toc;
