function [] = facerecognition_yale_eigen_3eigendiff()
listing = dir('../../CroppedYale');
x={listing.name};
%ORLdatabase = dir("../../att_faces");
count = 1;
identity = zeros(1520,1);
for i = 1:1:39
    if(i<14)
        filename = strcat(['../../CroppedYale/' x{i+2} ]);
        for j=1:1:40
            listing2 = dir(filename);
            y={listing2.name};
            filename2 = strcat([filename '/' y{j+2} ]);
            %movefile filename  ../../training_set
            img = imread(filename2);
            img = reshape(img,[],1);
            training_set(:,count) = img(:);   %192*168 x 1 x 192
            identity(count) = i;
            count = count + 1;
        end
    elseif(i>14)
        filename = strcat(['../../CroppedYale/' x{i+1} ]);
        for j=1:1:40
            listing2 = dir(filename);
            y={listing2.name};
            filename2 = strcat([filename '/' y{j+2} ]);
            %movefile filename  ../../training_set
            img = imread(filename2);
            img = reshape(img,[],1);
            training_set(:,count) = img(:);   %192*168 x 1 x 192
            identity(count) = i;
            count = count + 1;
        end
    end
end
%training_set(:,1));
mean = transpose(sum(transpose(training_set)))./(1520); % coz sum returns that of row...
%disp(size(mean));
%disp(size(training_set));
for i = 1:1:1520
 mean_centered_training_set(:,i) = double(training_set(:,i)) - mean;
end
%covariance = cov(mean_centered_training_set)./1519;
k_vector = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
recognition_vector = zeros(size(k_vector));
for k = 1:1:size(k_vector,2)
[V, D] = eig(mean_centered_training_set'*mean_centered_training_set);
U = mean_centered_training_set*V;
for i=1:1:1520
    U(:,i) = U(:,i)/norm(U(:,i)); 
end
U = U(:,end-4:-1:1520-k_vector(k)); % Top k eigen_vectors are extracted and stored in U
% Now U contains K eigen-vectors
eigen_coeff_training = U'*mean_centered_training_set;  % size k x 1520
%disp(eigen_coeff_training);
%disp(size(eigen_coeff_training));
%--TESTING PHASE
recognition_rate = 0;
%disp(size(y));
for i = 1:1:39
    if(i < 14) 
        filename = strcat(['../../CroppedYale/' x{i+2} ]);
        listing2 = dir(filename);
        y={listing2.name};
        for j=41:1:size(y,2)-2
            %disp(j);
            filename2 = strcat([filename '/' y{j+2} ]);
            %movefile filename  ../../training_set
            img = imread(filename2);
            img = reshape(img,[],1);
            eigen_coeff_testing = U'*(double(img(:)) - mean);  %10*1
        %disp(size(eigen_coeff_testing));
        diffs = pdist2(eigen_coeff_testing', eigen_coeff_training');
        [minimum_diff, minimum_id] = min(diffs);
        recognition_rate = recognition_rate + (i==identity(minimum_id));
        end
    end
    if(i > 14) 
        filename = strcat(['../../CroppedYale/' x{i+1} ]);
        listing2 = dir(filename);
        y={listing2.name};
        for j=41:1:size(y,2)-2
            filename2 = strcat([filename '/' y{j+2} ]);
            %movefile filename  ../../training_set
            img = imread(filename2);
            img = reshape(img,[],1);
            eigen_coeff_testing = U'*(double(img(:)) - mean);  %10*1
        %disp(size(eigen_coeff_testing));
        diffs = pdist2(eigen_coeff_testing', eigen_coeff_training');
        [minimum_diff, minimum_id] = min(diffs);
        recognition_rate = recognition_rate + (i==identity(minimum_id));
        end    
    end           
end
recognition_vector(k) = 100*recognition_rate/912;
fprintf ('K_vector= %d,Recogniton rate = %f\n',k_vector(k),recognition_vector(k));
end
%disp(recognition_vector);
plot(k_vector, recognition_vector);
xlabel('K vector');
ylabel('Recognition rate');
 title('Eigen Decomposition on Yale database with top 3 eigen-vectors removed');
end