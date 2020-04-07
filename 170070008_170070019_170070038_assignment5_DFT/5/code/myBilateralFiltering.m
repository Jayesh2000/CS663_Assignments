function output=myBilateralFiltering(M,im_orig,sigd,sigi)
    
r1=size(M,1);
c1=size(M,2);

%Finding the filter for distance
filtd=zeros(max(2*r1-1,2*c1-1));
for i=[1:1:size(filtd,1)]
    for j=[1:1:size(filtd,1)]
        filtd(i,j)=gaussmf(sqrt((r1-i)^2+(c1-j)^2),[sigd 0]);
    end
end

res=double(M);
M=double(M);

sum1=0;

%Doing the bilateral filtering
for i=[1:1:size(M,1)]
    for j=[1:1:size(M,2)]
        filtg=gaussmf(M,[double(sigi) double(M(i,j))]);
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
output = J;

end