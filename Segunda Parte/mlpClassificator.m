function [ classificated, erros, net ] = mlpClassificator( X, T, trInd, valInd, teInd, params )
%MLPCLASSIFICATOR Summary of this function goes here
%   Detailed explanation goes here

learningRate = params.learningRate;
hiddenNeuron = params.hiddenNeuron;
maxEpoch = params.maxEpoch;

[ ~, classLabels ] = max(T, [], 2);

net = feedforwardnet(hiddenNeuron, 'traingd');
net.layers{1}.transferFcn = 'logsig';
net.trainParam.lr = learningRate;
net.trainParam.epochs = maxEpoch;
net.trainParam.showWindow = false;

net.divideFcn = 'divideind';
net.divideParam.trainInd = trInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = [];

[ net, ~ ] = train(net, X', T');

y = net(X(teInd,:)');

[ ~ , classificated ] = max(y, [], 1);

erros = length(find(classificated' ~= classLabels(teInd))) / length(teInd);

end

