function [ k ] = gaussKernel( x, y, sigma )
%GAUSSKERNEL Summary of this function goes here
%   Detailed explanation goes here

k = exp(  ( -(x-y)^2 )  / ( 2*(sigma^2) ) );

end

