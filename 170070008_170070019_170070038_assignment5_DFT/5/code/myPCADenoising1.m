function output = myPCADenoising1(im1)
img = im2col(im1,[7 7],'sliding');
[V,D] = eig(img*img','matrix');
eigen_coefficient = V'*img;

%finding the denominator for Wiener filter update
sq = eigen_coefficient.^2;
sq1 = sum(sq,2)./size(sq,2);
avg_squared_eigen = max(0,sq1-400);
var1 = 1 + 400./avg_squared_eigen;

%updating eigen coefficients and finding the columns for patches
denoised_eigen = eigen_coefficient./var1;
img2 = V*denoised_eigen;

%making patch from each column and making image from distinct patches
distinct = col2im(img2,[7 7],[(size(im1,1)-6)*7 (size(im1,1)-6)*7],'distinct');

output = zeros(size(im1));
denoised = zeros(size(im1));
denominator = zeros(size(im1));
var2 = ones(7,7);

%reconstruction of denoised image
for i=1:1:size(im1,2)-6
    for j=1:1:size(im1,1)-6
        denoised(i:i+6,j:j+6) = distinct(7*(i-1)+1:7*(i-1)+7,7*(j-1)+1:7*(j-1)+7) + denoised(i:i+6, j:j+6);
        denominator(i:i+6,j:j+6) = denominator(i:i+6,j:j+6) + var2;
    end
end

%final denoised image
output = denoised./denominator;
end



