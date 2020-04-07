function myPatchBasedFiltering(InputImage)

%Given: window and patch sizes
window_length = 25;
patch_length = 9;  

%corrupting the image with noise
[ image_x, image_y ] = size(InputImage);
intensityrange = max(max(InputImage)) - min(min(InputImage));
%disp(max(max(InputImage)));
gaussian_noise = 0.05*intensityrange*randn([image_x image_y]);
CorruptedImage = InputImage + gaussian_noise;

Optimal_SD = 4; %optimal value found after iterations
SD_factoring = [1, 0.9, 1.1];
OutputImage = zeros(size(InputImage));

bar = waitbar(0,'Patch Based Filtering ..');
for k = 1:1:3
for i = 1:1:image_x
    for j = 1:1:image_y
        w_x_min = max(i-window_length,1);
        w_x_max = min(i+window_length,image_x);
        w_y_min = max(j-window_length,1);
        w_y_max = min(j+window_length,image_y);
        %window_size varies with pixel location, above lines of code return
        %the extreme coordinates of window around pixel iterated!!
        window = InputImage(w_x_min:w_x_max,w_y_min:w_y_max);
        [window_x,window_y] = size(window);

        pref_x_min = max(i-patch_length,1);
        pref_x_max = min(i+patch_length,image_x);
        pref_y_min = max(j-patch_length,1);
        pref_y_max = min(j+patch_length,image_y);
        %Patch_size varies with pixel location, above lines of code return
        %the extreme coordinates of REFERENCE patch around pixel iterated!!
        patch_ref = InputImage(pref_x_min:pref_x_max,pref_y_min:pref_y_max);
        [patch_ref_x,patch_ref_y] = size(patch_ref);

        weights = zeros(window_x,window_y);
        for ii = 1:1:window_x
        	for jj = 1:1:window_y
		         p_x_min = max(i-patch_length,1);
                 p_x_max = min(i+patch_length,image_x);
                 p_y_min = max(j-patch_length,1);
                 p_y_max = min(j+patch_length,image_y);
                 %Patch_size varies with pixel location, above lines of code return
                 %the extreme coordinates of other patchs within window (similar patches yet to be found below)!!
                 patch = InputImage(p_x_min:p_x_max,p_y_min:p_y_max);
                 [patch_x,patch_y] = size(patch);

		          if (patch_x==patch_ref_x && patch_x==patch_ref_x)
                    diff_patch = patch_ref - patch;                    
                  else
                    patch = patch(1:min(patch_x, patch_ref_x),1:min(patch_y,patch_ref_y));
                    normalised_ref_patch = patch_ref(1:min(patch_x, patch_ref_x),1:min(patch_y,patch_ref_y));
                    diff_patch = normalised_ref_patch - patch;
                  end
                  %Calculating relative weights for each pixel in the window
		          weights(ii,jj) = sum(sum(diff_patch.^2))/(size(diff_patch,1)*size(diff_patch,2));
        	end
        end
        
        %Calculating Normalised weight using gaussian with given Optimal_SD
        window_weight = exp(-1.*weights./((Optimal_SD.*SD_factoring(k))^2));
        window_weight = window_weight./(sum(sum(window_weight)));
        OutputImage(i,j) = sum(sum(window_weight.*window));

    end
    waitbar(i/size(InputImage,1), bar);
end

%Display Input Image
subplot(1,3,1);
imshow(mat2gray(InputImage)), colorbar;
title('Input Image')
%Display Corrupted Image
subplot(1,3,2);
imshow(mat2gray(CorruptedImage)), colorbar;
title('Corrupted Image')
%Display Output Image
subplot(1,3,3);
imshow(mat2gray(OutputImage)), colorbar;
title('Output Image')
%Calculating and displaying RSMD for given SD
diff_Image = OutputImage - InputImage;
RMSD = sqrt(sum(sum(diff_Image.^2))/(image_x*image_y));
disp(RMSD);
% Display SD
disp((Optimal_SD.*SD_factoring(k)));
end