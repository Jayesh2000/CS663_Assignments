function [] = myminifacerecognition()

%ORLdatabase = dir("../../att_faces");
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
recognition_rate = 0;
for i=1:1:32
    for j=7:1:10
        filename = strcat(['../../att_faces/s' num2str(i) '/' num2str(j) '.pgm']);
        img = imread(filename);
        eigen_coeff_testing = U'*(double(img(:)) - mean);  %10*1
        %disp(size(eigen_coeff_testing));
        diffs = pdist2(eigen_coeff_testing', eigen_coeff_training');
        [minimum_diff, minimum_id] = min(diffs);
        recognition_rate = recognition_rate + (i==identity(minimum_id));
    end
end
recognition_vector(k) = 100*recognition_rate/128;
fprintf ('K_vector= %d,Recogniton rate = %f\n',k_vector(k),recognition_vector(k));
end
%disp(recognition_vector);
plot(k_vector, recognition_vector);
xlabel('K vector');
ylabel('Recognition rate');
 title('SVD on ORL database');
end