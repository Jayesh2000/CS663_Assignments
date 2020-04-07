function [y]=funcHE(M,j,k,i,factor, epsilon)
hist = zeros(256,1);
limit = epsilon*factor*factor;
%{
if (j < factor + 1) || (k < factor + 1) || (k > size(M,2) - factor) || (j > size(M,1) - factor)
    y = M(j,k,i);
else
  %}

if (j < factor + 1) 
    iistart = 1;
    iiend = j+factor;
    if (k < factor + 1)       
        jjstart = 1;
        jjend = k+factor;
    elseif (k > size(M,2) - factor)
        jjstart = k-factor;
        jjend = size(M,2); 
    else
        jjstart = k-factor;
        jjend = k+factor;
    end    
elseif  (j > size(M,1) - factor)
     iistart = j-factor;
     iiend = size(M,1);
     if (k < factor + 1)       
        jjstart = 1;
        jjend = k+factor;
    elseif (k > size(M,2) - factor)
        jjstart = k-factor;
        jjend = size(M,2); 
    else
        jjstart = k-factor;
        jjend = k+factor;
    end      
else
     iistart = j-factor;
     iiend = j+factor;
     if (k < factor + 1)       
        jjstart = 1;
        jjend = k+factor;
    elseif (k > size(M,2) - factor)
        jjstart = k-factor;
        jjend = size(M,2); 
    else
        jjstart = k-factor;
        jjend = k+factor;
     end 
end
%{
iistart = j-factor;
iiend = j+factor;
jjstart = k-factor;
jjend = k+factor;
%}
 for ii=iistart:1:iiend
     for jj=jjstart:1:jjend
         hist(M(ii,jj,i)+1) = hist(M(ii,jj,i)+1) + 1;
     end
 end
 %hist = hist./(factor*factor);
 sum = 0;
 for ii=1:1:256
     if (hist(ii) > limit)
         sum = sum + hist(ii) - limit;
          hist(ii) = limit;
     end 
 end
hist = hist + sum./256;

for ii = 2:1:256
    hist(ii) = hist(ii) + hist(ii-1);
end
hist = hist.*(256)./hist(256);
y = hist(M(j,k,i)+1);
end