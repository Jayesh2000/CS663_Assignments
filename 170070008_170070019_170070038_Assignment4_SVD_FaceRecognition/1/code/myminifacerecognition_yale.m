function [] = facerecognition_yale()

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

    if(i > 14) 

        filename = strcat(['../images/CroppedYale/' x{i+2} ]);
    

        for j=41:1:64

            listing2 = dir(filename);

            y={listing2.name};

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

    elseif(i < 14) 

        filename = strcat(['../images/CroppedYale/' x{i+1} ]);

        for j=41:1:64

            listing2 = dir(filename);

            y={listing2.name};

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

recognition_vector(k) = 100*recognition_rate/912;