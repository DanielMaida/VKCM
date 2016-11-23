function [ phi ] = globalAdaptiveDistance( x, v, W, sigma )
%GLOBALADAPTIVEDISTANCE Summary of this function goes here
%   Detailed explanation goes here

[ ~, p ] = size(x);

% kernelVector = zeros(1, p);
distanceVector = zeros(1,p);

for i=1:p
%     kernelVector(i) = gaussKernel(x(i), v(i), sigma(i));
%     distanceVector(i) = 2 * (1 - kernelVector(i));
    distanceVector(i) = kernelDistance(x(i), v(i), sigma(i));
end;

phi = sum(W .* distanceVector);


end

