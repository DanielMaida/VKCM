function [ classificated, erros ] = mlpClassificator( X, T, trInd, valInd, teInd, params )
%MLPCLASSIFICATOR Summary of this function goes here
%   Detailed explanation goes here

learningRates = params.learningRate;
hiddenNeurons = params.hiddenNeurons;
maxEpochs = params.maxEpochs;

[ ~, classLabels ] = max(T, [], 2);

net = feedforwardnet(hiddenNeurons, 'traingd');
net.layers{1}.transferFcn = 'logsig';
net.trainParam.lr = learningRates
net.trainParam.epochs = maxEpochs
net.trainParam.showWindow = false;

net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = [];

[ net, ~ ] = train(net, X', Te');

y = net(X(testInd,:)');

[ ~ , classificated ] = max(y, [], 1);

erros = length(find(classificated' ~= classLabels(testInd))) / length(testInd);

end

