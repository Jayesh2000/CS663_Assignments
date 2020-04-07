%% MyMainScript

tic;
%% Your code here

IMG1=imread('..\data\circles_concentric.png');
%C:\Users\Anugole Sai Gaurav\Desktop\IIT Notes\Semester 5\CS663\assignment-1-transformations\1\codes
myShrinkImageByFactorD(IMG1);
IMG2 = imread("..\data\barbaraSmall.png");
myBilinearInterpolation(IMG2);
myNearestNeighborInterpolation(IMG2);

toc;
