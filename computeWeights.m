function [ W ] = computeWeights( X, V, sigma, P, K )
%COMPUTEWEIGHTS Summary of this function goes here
%   Detailed explanation goes here

[ n, p ] = size(X);

W = ones(1, p);

distanceMatrixDenominator = zeros(n, p);

for i=1:n
    k = P(i);
    for j=1:p
        distanceMatrixDenominator(i,j) = kernelDistance(X(i,j), V(k,j), sigma(j));
    end;
end;

denominator = sum(distanceMatrixDenominator);

expoent = 1/p;

for j=1:p;
    for l=1:p
        temp = 0;
        for i=1:n
           k = P(i);
           temp = temp + kernelDistance(X(i,l), V(k,l), sigma(l));
        end;
        W(j) = W(j) * temp;
    end;
end;

W = ( W .^ expoent ) ./ denominator;

end

