function[]=myBilateralFiltering(M,im_orig,sigd,sigi)

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
%imagesc (single (phantom)); % phantom is a popular test image
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

%M=imread("barbara.png");
%im_orig=imread("barbara.png");
%im_orig=double(im_orig);
figure, imshow(mat2gray(im_orig)), colormap, colorbar;
%Adding random gaussian noise
%M=Noise(M);
figure, imshow(mat2gray(M)), colormap, colorbar;
r1=size(M,1);
c1=size(M,2);
%sigd=2;
%sigi=24;

%Finding the filter for distance
filtd=zeros(max(2*r1-1,2*c1-1));
for i=[1:1:size(filtd,1)]
    for j=[1:1:size(filtd,1)]
        filtd(i,j)=gaussmf(sqrt((r1-i)^2+(c1-j)^2),[sigd 0]);
    end
end

figure, imshow(mat2gray(filtd(r1-10*sigd:r1+10*sigd,c1-10*sigd:c1+10*sigd).*255)), colormap, colorbar;

res=double(M);
M=double(M);

sum1=0;

%Doing the bilateral filtering
for i=[1:1:size(M,1)]
    for j=[1:1:size(M,2)]
        filtg=gaussmf(M,[double(sigi) double(M(i,j))]);
        %disp(filtg(1:10,1:10));
        filtd1=filtd(r1+1-i:2*r1-i,c1+1-j:2*c1-j);
        weight_matrix=filtg.*filtd1;
        
        sum_weight=sum(weight_matrix,'all');
        prod_matrix=M.*weight_matrix;
        sum_prod=sum(prod_matrix,'all');
        res(i,j)=double(sum_prod/sum_weight);
    end
end
sum1=double(sum1)/(r1*c1);
J=mat2gray(res);
figure, imshow(J), colormap, colorbar;
%figure, imshow(mat2gray(M));


disp(sqrt(immse(M,im_orig)));
disp(sqrt(immse(res,im_orig)));


end


