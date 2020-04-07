M=imread("retina.png");
r1=size(M,1);
c1=size(M,2);
num=size(M,3);
y=zeros(r1,c1,num);
disp(num);
M1=imread("retinaRef.png");
for i=1:1:num
    y(:,:,i)=myHM1(M(:,:,i),M1(:,:,i));
end
%y=LinStretch(M);
%disp(max(y,[],'all'));

if num==1
    J=mat2gray(y);
    imshow(J);
end
if num==3
    imshow(uint8(y));
end








