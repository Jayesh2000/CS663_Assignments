%% MyMainScript

tic;
%% Your code here

IMG1=load('..\data\barbara.mat');
myPatchBasedFiltering(IMG1.imageOrig);
% To view Patch Filtering for other images, please uncomment the following
% lines, simultation takes a lot of time to run, hence published for only
% one image
%IMG2=imread('..\data\grass.png');
%myPatchBasedFiltering(IMG2);
%IMG3=imread('..\data\honeyCombReal.png');
%myPatchBasedFiltering(IMG3);
toc;
