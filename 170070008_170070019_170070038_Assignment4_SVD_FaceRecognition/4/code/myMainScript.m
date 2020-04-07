tic;
[U,V,S]=MySVD([1 2 3; 4 5 6]);
disp(U*S*transpose(V));
toc;