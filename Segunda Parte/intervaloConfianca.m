function [ intervaloConfianca ] = intervaloConfianca( error, alpha, text )
%INTERVALOCONFIANCA Summary of this function goes here
%   Detailed explanation goes here

%Teste de hipotesi
SEM = std(error)/sqrt(length(error));     % Standard Error
ts = tinv([alpha/2  1-alpha/2],length(error)-1);% T-Score
intervaloConfianca = mean(error) + ts*SEM;% Intervalo de 95% de confiança

mu = mean(error);               % mean
sigma = std(error);             % std
cutoff1 = norminv(alpha, mu, sigma);
cutoff2 = norminv(1-alpha, mu, sigma);
x = [linspace(mu-4*sigma,cutoff1), ...
    linspace(cutoff1,cutoff2), ...
    linspace(cutoff2,mu+4*sigma)];
y = normpdf(x, mu, sigma);
plot(x,y)
title(text);

xlo = [x(x<=cutoff1) cutoff1];
ylo = [y(x<=cutoff1) 0];
patch(xlo, ylo, 'b')

xhi = [cutoff2 x(x>=cutoff2)];
yhi = [0 y(x>=cutoff2)];
patch(xhi, yhi, 'b')


end

