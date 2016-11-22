clear
clc
load('abaloneNorm.mat');

X = abaloneNorm(:,2:9);
iterations = 3;
K = 3;
[ n, p ] = size(X);

pairwiseDistancesN = ( n * ( n - 1 ) ) / 2;
pairwiseDistances = zeros(pairwiseDistancesN, p);
for i=1:p
    pairwiseDistances(:,i) = pdist(X(:,i)) .^2 ;
end;
percentage = round(pairwiseDistancesN*0.1);
sortedDistances = sort(pairwiseDistances);
sigmaDistances = [ sortedDistances(percentage,:) ; sortedDistances(end-percentage,:) ];
sigma = mean(sigmaDistances);

bestV = zeros(K, p);
bestJ = realmax;
bestW = zeros(K, p);
bestIteration = 1;
sortedJ = zeros(iterations, 1);

for it=1:iterations
    
    fprintf('Começando Iteração %d\n', it);
    
    ind = 1;
    Js = zeros(10000, 1);
    
    W = ones(1, p);
    V = zeros(K, p);
    P = zeros(n, 1);
    
    initialV = randperm(n, K);
    
    % Selecionar clusters inicias aleatoriamente
    for j=1:K
        V(j,:) = X(initialV(j),:);
    end;
    
    % Determinar partições iniciais
    for i=1:n
        distances = zeros(1, K);
        for k=1:K
            distances(k) = globalAdaptiveDistance(X(i,:), V(k,:), W, sigma);
        end;
        [ ~, P(i)] = min(distances);
    end;
    
    J = costFunction(X, V, P, W, sigma);
%     fprintf('Inicial Função Custo = %.3f\n', J);
    
    Js(ind) = J;
    ind = ind + 1;
    
    while true
        % Cluster Centroids Update
        for j=1:K
            V(j,:) = computeCluster(X(P==j,:), V(j,:), sigma);
        end;
        
        % Weight Update
        W = computeWeights(X, V, sigma, P, K);
        
        % Update Clusters
        test = 0;
        
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
        
        J = costFunction(X, V, P, W, sigma);
%         fprintf('Função Custo = %.3f\n', J);
        
        Js(ind) = J;
        ind = ind + 1;
        
        if test == 0
            break;
        end;
    end;
    
    sortedJs = sort(Js, 'descend');
    sortedJ(it) = isequal(Js, sortedJs);
    
    J = costFunction(X, V, P, W, sigma);
    
    if J < bestJ
        bestJ = J;
        bestV = V;
        bestW = W;
        bestIteration = it;
    end;
end;

fprintf('\nMelhor Iteração : %d com custo %.3f\n', bestIteration, bestJ);
for i=1:K
    fprintf('Centro %d:\n', i);
    fprintf('%.3f   ', bestV(i,:));
    fprintf('\n');
end;
fprintf('Pesos :\n');
fprintf('%.3f   ', bestW);
fprintf('\n');