function output=myPCADenoising2(im1,sigma)
denoised = zeros(size(im1));
row=size(im1,1);
col=size(im1,2);
img3 =zeros(49,(row-6)*(row-6)); %to store the denoised patches in columns
for i=1:1:row-6
    for j=1:1:col-6
        P_ij=im1(i:i+6,j:j+6);
        neighborhood = im1(max(1,i-15):min(row,i+15),max(1,j-15):min(col,j+15));
        img1 = im2col(neighborhood,[7 7],'sliding');
        
        %finding 200 most similar patches from the neighbourhood
        Idx = knnsearch(img1',P_ij(:)','K',min(200,size(img1,2)));
        img = img1(:,Idx);
        
        [V,D] = eig(img*img','matrix');
        eigen_coefficient = V'*img;
        
        %finding the denominator for Wiener filter update
        sq = eigen_coefficient.^2;
        sq1 = sum(sq,2)./size(sq,2);
        avg_squared_eigen = max(0,sq1-sigma);
        var1 = 1 + sigma./avg_squared_eigen;
        
        %finding denoised eigen coefficient corresponding to the patch
        eigen_coefficient_2 = V'*P_ij(:);
        denoised_eigen = eigen_coefficient_2./var1;
        
        %finding denoised column corresponding to the patch
        img2 = V*denoised_eigen;
        
        %updating the columns of img3 
        img3(:,(row-6)*(j-1)+i) = img2;
    end
end

%making patch from each column and making image from distinct patches
distinct = col2im(img3,[7 7],[(size(im1,1)-6)*7 (size(im1,1)-6)*7],'distinct');

%reconstruction of denoised image
denominator = zeros(size(im1));
var2 = ones(7,7);
for i=1:1:size(im1,2)-6
    for j=1:1:size(im1,1)-6
        denoised(i:i+6,j:j+6) = distinct(7*(i-1)+1:7*(i-1)+7,7*(j-1)+1:7*(j-1)+7) + denoised(i:i+6, j:j+6);
        denominator(i:i+6,j:j+6) = denominator(i:i+6,j:j+6) + var2;
    end
end

%final denoised image
output = denoised./denominator;
end
        
