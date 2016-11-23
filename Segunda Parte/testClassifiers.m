clear
clc
load abalone.mat

X = abalone(:,2:9);
T = abalone(:,1);

CVO = cvpartition(T, 'KFold', 10);

% classificated = zeros(10, 4);
erros = zeros(10, 4);

for i=1:CVO.NumTestSets
    teIndLogical = CVO.test(i);
    trIndLogical = CVO.training(i);
    
    trInd = find(trIndLogical==1);
    teInd = find(teIndLogical == 1);
    
    testData = X(teInd, :);
    testClasses = T(teInd, :);
    trainData = X(trInd, :);
    trainClasses = T(trInd, :);
    
    trSize = CVO.TrainSize(i);
    percentageVal = round(trSize * 0.2);
    valInd = trInd(end-percentageVal:end,:);
    trIndMLP = trInd(1:end-percentageVal,:);
    
    [ classificatedBayes, erros(i,1), ~ ] = ...
        mvnpdfClassificator(testData, testClasses, trainData, trainClasses);
    
    [ classificatedSVM, erros(i,2) ] = ...
        svmClassificator(testData, testClasses, trainData, trainClasses);
    
%     [ classificatedMLP, erros(i,3) ] = ...
%         mlpClassificator(X, T, params, trIndMLP, valInd, teInd);
    
    estimatedClass = [ classificatedBayes, classificatedSVM ];
    
    [ classificatedMajoritario, erros(i,4), ~ ] = ...
        Majoritario(estimatedClass, testClasses);
    
end;

intervaloConfiancaBayes = intervaloConfianca(erros(:,1), 0.5);
intervaloConfiancaSVM = intervaloConfianca(erros(:,2), 0.5);
% intervalConfiancaMLP = intervaloConfianca(erros(:,3), 0.5);
intervaloConfiancaMajoritario = intervaloConfianca(erros(:,4), 0.5);

erros = [ erros(:,1:2) erros(:,4) ];

friedman(erros, 3);