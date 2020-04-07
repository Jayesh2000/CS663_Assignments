%% MyMainScript

tic;
%% Your code here
%ALGORITHM: A Threshold is first calculated based on the correlation
%between the images as the training set. For the other four of the same
%trained images, incase the sqaure error shall remain with the bounds of
%the given threshold and hence, serves as a criteria for matching Identity.
%For the untrained set, the difference is usually greater than the 
%threshold and can be used to report no identity match then!
count = 1;
identity = zeros(192,1);
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
k_vector = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
recognition_vector = zeros(size(k_vector));
for k = 1:1:size(k_vector,2)
[U, S, V] = svds(mean_centered_training_set, k_vector(k)); 
% Now U contains K eigen-vectors
%disp(size(U));
eigen_coeff_training = U'*mean_centered_training_set;  % size k x 192
%disp(eigen_coeff_training);
%disp(size(eigen_coeff_training));
%--TESTING PHASE
for i=1:32
    eigcoeffs_training_perperson = eigen_coeff_training(:,identity == i);    
    dist = zeros(6,6);
    for k1=1:6
        for k2=1:6
            distance(k1,k2) = sum(eigcoeffs_training_perperson(1:k,k1)-eigcoeffs_training_perperson(1:k,k2)).^2;
        end
    end
    thres(i) = max(distance(:));    
end
%Value of threshold chosen based on the training set images
threshold = median(thres)*3e-4;
false_positive = 0;
%False positives computed over untrained set
for i = 33:1:40
    for j = 1:1:10
        filename = strcat(['../../att_faces/s' num2str(i) '/' num2str(j) '.pgm']);
        img = imread(filename);
        eigen_coeff_testing = U'*(double(img(:)) - mean);  %10*1
        diffs = pdist2(eigen_coeff_testing', eigen_coeff_training');
        [minimum_diff, minimum_id] = min(diffs);
        if (minimum_diff < threshold)
            false_positive = false_positive+1;
        end
    end
end
 fprintf ('K_vector= %d,False positives = %f\n',k_vector(k),false_positive);
false_negative = 0;
%False negative computed over trained set
for i = 1:1:32
    for j = 7:1:10
        filename = strcat(['../../att_faces/s' num2str(i) '/' num2str(j) '.pgm']);
        img = imread(filename);
        eigen_coeff_testing = U'*(double(img(:)) - mean);  %10*1
        diffs = pdist2(eigen_coeff_testing', eigen_coeff_training');
        [minimum_diff, minimum_id] = min(diffs);
        if (minimum_diff > threshold)
            false_negative = false_negative+1;
        end
    end
end
 %false_negative = false_negative/128;
 fprintf ('K_vector= %d,False negatives = %f\n',k_vector(k),false_negative);
end

toc;
