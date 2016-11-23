function [ classificated, erros ] = svmClassificator( testData, testClasses, trainData, trainClasses )
%SVMCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here


svmModel = fitcecoc(trainData, trainClasses);

classificated = predict(svmModel, testData);

erros = length(find(classificated ~= testClasses)) / length(testClasses);

end

