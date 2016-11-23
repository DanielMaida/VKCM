function [ maj, error , confusion] = Majoritario( estimedclass, realclass)

    maj = mode(estimedclass, 2)
    error = sum((maj == realclass))/ size(realclass, 1)

    confusion = zeros(3,3)
    
    
    %calcula o erro e a matriz de confusao
    for i=1: size(realclass, 1)
       
       if(maj(i, 1) ~=realclass(i))
           error=error+1;
       end
       confusion(min(maj(i, 1), realclass(i)), max(maj(i, 1), realclass(i))) = confusion(min(maj(i, 1), realclass(i)), max(maj(i, 1), realclass(i))) +1;
    end
end


