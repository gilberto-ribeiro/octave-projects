function dydx = concentracao_edos(x,y)
    %Parâmetros globais
    global D Kd kf qm R V v E C0 c0 n r hr solver

    %Identificação das variáveis
    c = y(1:n);
    C = y(n+1);

    %EDOs
    for i = 1:n
        G = 1+(1/E-1)*(qm*Kd)/((Kd+(C0-c0)*c(i)+c0)^2);
        if i == 1
            c_0  = c(2);
            Dc   = 0;
            DDc  = 3*(c(i+1)-2*c(i)+c_0)/(hr^2);
        elseif i == n
            cn_1 = c(i-1)+((2*hr*kf*R)/(D*E))*(C-c(i));
            Dc   = (2/r(i))*((cn_1-c(i-1))/(2*hr));
            DDc  = (cn_1-2*c(i)+c(i-1))/(hr^2);
        else
            Dc   = (2/r(i))*((c(i+1)-c(i-1))/(2*hr));
            DDc  = (c(i+1)-2*c(i)+c(i-1))/(hr^2);
        endif
        dc(i) = (1/G)*(DDc+Dc);
    endfor
    dC = -((3*v*kf*R)/(D*V))*(C-c(n));

    %Vetor de saída
    switch solver
        case('rk4')
        dydx = [dc dC];
        case('ode45')
        dydx = [dc dC]';
    endswitch
endfunction
