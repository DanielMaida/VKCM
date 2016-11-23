function [ J ] = costFunction( X, V, P, W, sigma )
%COSTFUNCTION Summary of this function goes here
%   Detailed explanation goes here

[ n, ~ ] = size(X);

J = 0;

for i = 1:n
    k = P(i);
    J = J + globalAdaptiveDistance(X(i,:), V(k,:), W, sigma);
end;


end

