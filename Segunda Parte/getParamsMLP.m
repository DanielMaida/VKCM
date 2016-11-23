function [ params ] = getParamsMLP( X, T )
%GETPARAMSMLP Summary of this function goes here
%   Detailed explanation goes here

idx = 1;
comb = zeros(27,3);
validationPerf = zeros(27,1);

learningRates = [ 0.01, 0.03, 0.1 ];
hiddenNeurons = [ 8, 16, 50 ];
maxEpochs = [ 100, 500, 1000 ];

for p1=1:3
    for p2=1:3
        for p3=1:3
            rng('default');
            
            net = feedforwardnet(hiddenNeurons(p1), 'traingd');
            net.layers{1}.transferFcn = 'logsig';
            net.trainParam.lr = learningRates(p2);
            net.trainParam.epochs = maxEpochs(p3);
            net.trainParam.showWindow = false;
                 
            [ ~, tr ] = train(net, X', T');
            
            validationPerf(idx) = tr.best_vperf;
            comb(idx,:) = [ p1 p2 p3 ];
            idx = idx + 1;
        end;
    end;
end;

[ ~, bestPerformV ] = min(validationPerf);

p1 = comb(bestPerformV, 1);
p2 = comb(bestPerformV, 2);
p3 = comb(bestPerformV, 3);

params.learningRate = learningRates(p2);
params.hiddenNeuron = hiddenNeurons(p1);
params.maxEpoch = maxEpochs(p3);


end

