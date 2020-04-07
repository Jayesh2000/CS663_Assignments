M=imread("canyon.png");
r1=size(M,1);
c1=size(M,2);
num=size(M,3);
y=zeros(r1,c1,num);
disp(num);
for i=1:1:num
    y(:,:,i)=myHE(M(:,:,i));
end
%y=LinStretch(M);
%disp(max(y,[],'all'));

if num==1
    J=mat2gray(y);
    imshow(J);
end
if num==3
    figure,imshow(uint8(y));
end








