function last(M)
hist = zeros(256, size(M,3));
outimg = zeros(size(M));
for i=1:1:size(M,3)
      hist = imhist(M(:,:,i));
      %{
      sum_hist = sum(hist);
      median_mass = sum_hist/2;
      for j=1:1:size(hist,1)
          if (median_mass >= hist(j,i))
              median_hist = j;
              break
          end
      end
      %}
      median_hist = 120;
      hist1 = zeros(median_hist);
      hist2 = zeros(256 - median_hist);
      hist1(1) = hist(1);
      for j = 2:1:median_hist
         hist1(j) = hist1(j-1) + hist(j);          
      end
      hist1 = hist1.*median_hist./hist1(median_hist);
      hist2(1) = hist(median_hist + 1);
      for j = 2:1:256-median_hist
         hist2(j) = hist2(j-1) + hist(j+median_hist);          
      end
      hist2 =  (hist2 + median_hist).*(256-median_hist)./hist2(256-median_hist);
      for k=1:1:size(M,1)
            for n = 1:1:size(M,2)
                if (M(k,n,i)+1 > median_hist)
                    outimg(k,n,i) = hist2(M(k,n,i) + 1 - median_hist);
                else
                    outimg(k,n,i) = hist1(M(k,n,i) + 1);
                end
            end
      end
end
    J = mat2gray(outimg);
    figure, subplot(1,2,2), imshow(J, imref2d(size(J))), colormap, colorbar;
    title('Bi-histogram equalised Image');
    subplot(1,2,1), imshow(M,imref2d(size(M))),  colormap, colorbar;
    title('Original Image');
    suptitle('Bi-Histogram Equalisation');
end