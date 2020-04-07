function myHE(M)
%M=imread("canyon.png");
histeql = zeros(256, size(M,3));
outimg = zeros(size(M));
    for i=1:1:size(M,3)
        hist = imhist(M(:,:,i));
        sum=0;
        for j=1:1:size(hist,1)
            sum= sum + hist(j);
            histeql(j,i) = sum;
        end
        histeql(:,i) = histeql(:,i).*256.0./sum;
        for k=1:1:size(M,1)
            for n = 1:1:size(M,2)
                outimg(k,n,i) = histeql(M(k,n,i)+1,i);
            end
        end
    end   
     J = mat2gray(outimg);
    figure, subplot(1,2,2), imshow(J, imref2d(size(J))), colormap, colorbar;
    title('Histogram Equalised Image');
    subplot(1,2,1), imshow(M,imref2d(size(M))),  colormap, colorbar;
    title('Original Image');
    suptitle('Histogram Equalisation');
    end