function [Cp,H,S] = nist(T,coef)
    T    = reshape(T,length(T),1);
    t    = T/1000;
    um   = ones(length(T),1);
    zero = zeros(length(T),1);
    tcp  = [    um      t   t.^2   t.^3    1./(t.^2) zero zero]';
    th   = [     t t.^2/2 t.^3/3 t.^4/4        -1./t   um zero]';
    ts   = [log(t)      t t.^2/2 t.^3/3 -1./(2*t.^2) zero   um]';
    Cp   = coef*tcp; %J/mol.K
    H    = coef*th;  %kJ/mol
    S    = coef*ts;  %J/mol.K
endfunction
