function [ k ] = gaussKernel( x, y, sigma )
%GAUSSKERNEL Summary of this function goes here
%   Detailed explanation goes here

k = exp( -pow2(abs(x-y)) / (2*pow2(sigma)) );

end

