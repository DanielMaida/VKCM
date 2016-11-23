function [ intervaloConfianca ] = intervaloConfianca( error, alpha )
%INTERVALOCONFIANCA Summary of this function goes here
%   Detailed explanation goes here

%Teste de hipotesi
SEM = std(error)/sqrt(length(error));     % Standard Error
ts = tinv([alpha/2  1-alpha/2],length(error)-1);% T-Score
intervaloConfianca = mean(error) + ts*SEM;% Intervalo de 95% de confiança


end

