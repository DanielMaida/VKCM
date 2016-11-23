function [ d ] = kernelDistance( x, y, sigma )
%KERNELDISTNACE Summary of this function goes here
%   Detailed explanation goes here

d = 2 * (1 -  gaussKernel(x, y, sigma) );

end

