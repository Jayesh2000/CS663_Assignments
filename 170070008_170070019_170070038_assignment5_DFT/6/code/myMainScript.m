%% MyMainScript

tic;
%% Your code here
I=zeros(300,300);
J=I;
%Assigning the value of I
I(50:99,50:119)=255*ones(50,70);
%imshow(mat2gray(I));
%Assigning the value of J
tx=-30;
ty=70;
J(50+tx:99+tx,50+ty:119+ty)=255*ones(50,70);
%figure,imshow(mat2gray(J));
%Adding Gaussian Noise
%I=imnoise(I,'gaussian',0,400);
%J=imnoise(J,'gaussian',0,400);
%Doing the fourier transform calculations
F1=fft2(I);
F2=fft2(J);

Cross=F1;
%Doing this via traditional method
for i=[1:1:300]
    for j=[1:1:300]
        Cross(i,j)=F2(i,j)*conj(F1(i,j))/(abs(F1(i,j)*F2(i,j))+10e-40);
    end
end

OutCross=ifft2(Cross);
m=max(OutCross,[],'all');
for i=[1:1:300]
    for j=[1:1:300]
        if (OutCross(i,j)==m)
            if (i-1>150)
                disp(i-1-300);
            else
                disp(i-1);
            end
            if (j-1>150)
                disp(j-1-300);
            else
                disp(j-1);
            end
        
        end
    end
end
figure,imshow(mat2gray(log(1+abs(Cross))));
title("Cross- Spectral Density");
figure,imshow(mat2gray(OutCross));
title("Inverse Fourier Transform of Cross Spectral Density");
toc;
