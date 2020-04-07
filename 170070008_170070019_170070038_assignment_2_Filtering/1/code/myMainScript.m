%% MyMainScript

tic;
%% Your code here
IMG1 = imread('../data/flower.jpg');
IMG2 = imread('../data/bird.jpg');
mySpatiallyVaryingKernel(IMG1);
mySpatiallyVaryingKernel(IMG2);
toc;
