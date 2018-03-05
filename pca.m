%{
function pca
i=1;
error=zeros(40,1);
K=zeros(40,1);
for k=10:10:400
    [error(i) U]=Pca(k);
    K(i)=k;
    i=i+1;
end

plot(K,error);
title('reconstruction error vs number of PCs');
ylabel('reconstruction error');
xlabel('K');
end
%}
K=191;
%function [error U]=Pca(K)
%reading the input
 X=csvread('data.txt');
N=size(X,1);
%calculate the variance
var=(transpose(bsxfun(@minus,X,mean(X)))*(bsxfun(@minus,X,mean(X))))/N;
%get the eigenvectors in descending order
[U S V]=svd(var);
%extract K top eigenvectors
U=U(:,1:K);
%get principle components
Z=X*U;
%re-project the data in original space
reX=Z*transpose(U);
%calculate  the error
diff=(X-reX).*(X-reX);
error=sum(diff(:))/N;
%end