clear
clc
load('abaloneNorm.mat');

X = abaloneNorm(:,1:8);
iterations = 10;
K = 3;
[ n, p ] = size(X);

pairwiseDistancesN = ( n * ( n - 1 ) ) / 2;
pairwiseDistances = zeros(pairwiseDistancesN, p);
for i=1:p
    pairwiseDistances(:,i) = pdist(X(:,i));
end;
percentage = round(pairwiseDistancesN*0.1);
sortedDistances = sort(pairwiseDistances);
sigmaDistances = [ sortedDistances(1:percentage,:) ; sortedDistances(end-percentage:end,:) ];
sigma = mean(sigmaDistances);

bestV = zeros(K, p);
bestJ = realmax;
bestIteration = 1;

for it=1:iterations
    
    W = ones(1, p);
    V = zeros(K, p);
    P = randi(K, n, 1);
    
    for j=1:K
        V(j,:) = datasample(X(P==j,:), 1);
    end;
    
    while true
        % Cluster Centroids Update
        temp = V;
        for j=1:K
            V(j,:) = computeCluster(X(P==j,:), V(j,:), sigma);
        end;
        
        % Weight Update
        W = computeWeights(X, V, sigma, P, K);
        
        % Update Clusters
        test = 0;
        
        tempP = P;
        for i=1:n
            initialCluster = P(i);
            distances = zeros(1, K);
            for k=1:K
                distances(k) = globalAdaptiveDistance(X(i,:), V(k,:), W, sigma);
            end;
            [ ~, finalCluster] = min(distances);
            
            if initialCluster ~= finalCluster
                P(i) = finalCluster;
                test = 1;
            end;
        end;
        
        if test == 0
            break;
        end;
    end;
    
    J = costFunction(X, V, P, W, sigma);
    
    if J < bestJ
        bestJ = J;
        bestV = V;
        bestIteration = it;
    end;
end;

fprintf('\nMelhor Iteração : %d com custo %.3f\n', bestIteration, bestJ);
for i=1:K
    fprintf('Centro %d:\n', i);
    fprintf('%.3f  ', bestV(i,:));
    fprintf('\n');
end;