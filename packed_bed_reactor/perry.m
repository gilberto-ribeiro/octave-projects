function [M,Mu] = perry(T,coef)
    T  = reshape(T,length(T),1);
    C  = coef(:,2:columns(coef));
    C1 = C(:,1); C2 = C(:,2);
    C3 = C(:,3); C4 = C(:,4);
    um = ones(length(T),1);
    for i = 1:rows(C)
        Mu(:,i) = (C1(i).*T.^C2(i))./(um+C3(i)./T+C4(i)./(T.^2));
    endfor
    M  = coef(:,1); %g/mol
    Mu = Mu';       %Pa.s
endfunction
