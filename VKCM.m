% INPUT = data set
data_set = load abalone.data; %check if this is right, probabably not
% INPUT = number of clusters
number_of_clusters = 3;
% INPUT = parameter B
betaparameter = 100; %check this later

function k = gaussianKernel(x,y)
	k = (1/sqrt(2*pi)*y) * e^(-(pow2(x)/2*pow2(y)));
endfunction

% OUTPUT = vector of relevant weights of the variables lambda
% OUTPUT = partition P of the data set X into K clusters
% OUTPUT = Cluster centroids
