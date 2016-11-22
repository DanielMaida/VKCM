function [ newV ] = computeCluster( X, oldV, sigmas )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[ n, p ] = size(X);
kernelMatrix = zeros(n, p);

for i=1:n
    for j=1:p
        kernelMatrix(i, j) = gaussKernel(X(i,j), oldV(j), sigmas(j));
    end;
end;

newV = ( sum(kernelMatrix .* X) ) ./ sum(kernelMatrix);

end

