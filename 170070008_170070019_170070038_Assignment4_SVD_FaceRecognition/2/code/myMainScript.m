%% MyMainScript

tic;
%% Your code here
count = 1;
identity = zeros(192,1);
path = '../Images/';
for i = 1:1:32
    for j=1:1:6
      filename = strcat(['../../att_faces/s' num2str(i) '/' num2str(j) '.pgm']);
      %movefile filename  ../../training_set
      img = imread(filename);
      training_set(:,count) = img(:);   %92*112 x 1 x 192
      identity(count) = i;
      count = count + 1;
    end
end
%training_set(:,1));
mean = transpose(sum(transpose(training_set)))./(192); % coz sum returns that of row...
%disp(size(mean));
%disp(size(training_set));
for i = 1:1:192
 mean_centered_training_set(:,i) = double(training_set(:,i)) - mean;
end
%covariance = cov(mean_centered_training_set)./191;
k_vector = [2, 10, 20, 50, 75, 100, 125, 150, 175];
recognition_vector = zeros(size(k_vector));
for k = 1:1:size(k_vector,2)
[U, S, V] = svds(mean_centered_training_set, k_vector(k)); 
%disp(size(U));
eigen_coeff_training = U'*mean_centered_training_set;  % size k x 192
%disp(size(eigen_coeff_training));
reconstructed_image = U*eigen_coeff_training(:,50) + mean; %reconstructing 50th column image!!
reconstructed_image = reshape(reconstructed_image,112,92);
filename = strcat([path 'Reconstructed_Image' num2str(k) '.png']);
imwrite(uint8(reconstructed_image), filename);
Fim = zeros(112,92,25);
for i=1:1:25 % TOP 25 eigenvectors!
    eigenface = log(1+(abs(fftshift(fft2(reconstructed_image)))));
    subplot(5,5,i); imshow(mat2gray(eigenface));
    filename = strcat([path 'Eigenface' num2str(i) '.png']);
    imwrite(mat2gray(eigenface), filename);
end

end

toc;
