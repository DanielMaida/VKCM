function [ maj, error , confusion] = Majoritario( estimatedClass, realclass)

    maj = mode(estimatedClass, 2);
    error = sum((maj ~= realclass)) / size(realclass, 1);

    confusion = zeros(3,3);
    
    
    %calcula o erro e a matriz de confusao
    for i=1: size(realclass, 1)
       confusion(min(maj(i, 1), realclass(i)), max(maj(i, 1), realclass(i))) = confusion(min(maj(i, 1), realclass(i)), max(maj(i, 1), realclass(i))) +1;
    end
end


