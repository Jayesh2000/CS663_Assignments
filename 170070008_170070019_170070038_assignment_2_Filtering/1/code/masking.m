function y=masking(A)
if size(A,1)<350
    C=A(:,:,3);
else
    C=A(:,:,1);
end
row=size(C,1);
col=size(C,2);
mask=zeros(size(C));
for i=1:1:row
    for j=1:1:col
        if (C(i,j))>90
            mask(i,j)=255;
        end
    end
end
if row<350
    mask(1:row,1:floor(col/3))=0;
    mask(floor(row/2-30):floor(row/2)+30,floor(col/2)-30:floor(col/2)+30)=255;
else
    mask(1:floor(row/3),floor(col/2):col)=0;
    mask(1:row,floor((5*col)/7):col)=0;
    mask(1:row,1:floor((1*col)/5))=0;
    mask(floor(row/3):floor(row/2),1:floor((2*col)/7))=0;
    mask(floor(row/3):floor(row/2),1:floor((2*col)/7))=0;
    
end


y=mask;



                   
               