function [y]=Noise(x)
    r1=size(x,1);
    c1=size(x,2);
    disp(r1);
    disp(c1);
    max1=max(x(:));
    min1=min(x(:));
    disp(min1);
    disp(max1);
    sd1=0.05*(max1-min1);
    for i=1:1:r1
        for j=1:1:c1
            y(i,j)=x(i,j)+sd1*randn;
        end
    end
    
end


