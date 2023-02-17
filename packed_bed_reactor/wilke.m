function mumix = wilke(x,mu,M)
    n = length(mu);
    for i = 1:n
        for j = 1:n
            if i == j
                phi(i,j) = 0;
            else
                phi(i,j) = ((1+((mu(i)/mu(j))^(1/2))*((M(j)/M(i))^(1/4)))^2)/((4/sqrt(2))*(1+(M(i)/M(j)))^(1/2));
            endif
        endfor
    endfor
    mumix = sum(mu./(1+(1./x).*sum((x'.*phi)')'));
endfunction
