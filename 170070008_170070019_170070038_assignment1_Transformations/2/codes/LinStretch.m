function [y]=LinStretch(x)
    r1=size(x,1);
    c1=size(x,2);
    max_elem=max(x,[],'all');
    disp(max_elem);
    min_elem=min(x,[],'all');
    disp(min_elem);
    y=zeros(r1,c1);
    for i=1:1:r1
        for j=1:1:c1 
            o1=double(x(i,j)-min_elem);
            o2=double(max_elem-min_elem);
            o3=o1/o2;
            y(i,j)=(255*o3);            
        end
    end
    %disp(y);
end


