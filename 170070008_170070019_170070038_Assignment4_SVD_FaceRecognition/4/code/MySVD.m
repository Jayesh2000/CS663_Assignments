function[U,V,S]=MySVD(A)
%A=[1 2; 4 10; 3 3];
    
m=size(A,1);
n=size(A,2);
M1=A*transpose(A);
M2=transpose(A)*A;

[V,SM2]=eig(M2);
%[U,SM1]=eig(M1);

%disp(U);
%disp(U*transpose(U));

%[D1,ind1] = sort(diag(SM1),'descend');
[D2,ind2] = sort(diag(SM2),'descend');

V=V(:,ind2);
%U=U(:,ind1);

S1=zeros(m,n);
S2=zeros(m,n);

S=eig(M2);
S=sqrt(S);
S=sort(S,'descend');

for i=1:min(m,n)
    S1(i,i)=1/S(i);
    S2(i,i)=S(i);
end

%disp(S1);

%disp(A);

%disp(V);

U=A*V*transpose(S1);

S=S2;

%Out=U*S2*transpose(V);

%disp(Out);


    
end