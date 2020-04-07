
%Doing bilateral filtering for grass first
M=load('..\data\grassNoisy.mat');
M=M.imgCorrupt;
M=M.*255;
M=double(M);
im_orig=imread("..\data\grass.png");
im_orig=double(im_orig);
sigd=0.8;
sigi=45;
myBilateralFiltering(M,im_orig,sigd,sigi);

%Doing bilateral filtering for honeycomb next

M=load('..\data\honeyCombReal_Noisy.mat');
M=M.imgCorrupt;
M=M.*255;
M=double(M);
im_orig=imread("..\data\honeyCombReal.png");
im_orig=double(im_orig);
sigd=0.98;
sigi=36;
myBilateralFiltering(M,im_orig,sigd,sigi);

%Doing it for barbara next. Barbara takes more than 5 minutes

M=load("..\data\barbara.mat");
M=M.imageOrig;
disp(max(M(:)));
M=double(M);
M=M.*2.55;
im_orig=M;
M=Noise(M);
sigd=2;
sigi=24;
myBilateralFiltering(M,im_orig,sigd,sigi);