% INPUT = data set
load ("data.mat"); %check if this is right, probabably notd
% INPUT = number of clusters
number_of_clusters = 3;
% INPUT = parameter B
betaparameter = 100; %check this later

function k = gaussianKernel(x,y,sigma)
    k = e^(-(pow2(mod(x-y))/2*pow2(sigma));
endfunction

function k = gaussianKernelProduct(x,y,sigma)
    k = gaussianKernel(x,y,sigma)*x;
endfunction

function r = centroidCalculator(attribute,centroid)
    
endfunction
 

% OUTPUT = vector of relevant weights of the variables lambda
% OUTPUT = partition P of the data set X into K clusters
% OUTPUT = Cluster centroids
