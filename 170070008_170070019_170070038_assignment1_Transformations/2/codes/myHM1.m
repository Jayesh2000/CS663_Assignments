function [y]=myHM1(x1,x2)

    %Calculating histogram of image one
    r1=size(x1,1);
    c1=size(x1,2);
    y=zeros(r1,c1);
    bin=zeros(256,1);
    
    bin=histcounts(x1,0:1:256);
    sum1=double(sum(bin));
    for i=2:1:256
        bin(i)=bin(i)+bin(i-1);
    end
    bin=double(bin); 
    bin=bin./sum1;
    hist1=bin;
    
    %Calculating histogram of image two
    r1=size(x2,1);
    c1=size(x2,2);
    bin=zeros(256,1);
    
    bin=histcounts(x2,0:1:256);
    sum1=double(sum(bin));
    for i=2:1:256
        bin(i)=bin(i)+bin(i-1);
    end
    bin=double(bin); 
    bin=bin./sum1;
    hist2=bin;
    
    r1=size(x1,1);
    c1=size(x1,2);
    %Doing the inversion
    for i=1:1:r1
        for j=1:1:c1
            i1=double(hist1(x1(i,j)+1));
            for k=1:1:256
                if (i1>=hist2(k))
                    y(i,j)=k;
                end
            end
        end
    end
    
end


