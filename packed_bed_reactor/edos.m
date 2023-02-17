function dydx = edos(x,y)
    %Parâmetros globais
    global cNIST cPerry nu A Ea R KE n eB rhop dp rhoB eta U
    global D Ac Ttype Tvartype Ptype cateffect cattype Njf

    %Identificação de variáveis
    NE = y(1); NO = y(2); NEO = y(3);                                                  %mol/s; mol/s; mol/s
    NC = y(4); NW = y(5); NI  = y(6);                                                  %mol/s; mol/s; mol/s
    T  = y(7); P  = y(8); Ta  = y(9);                                                  %K;     Pa;    K
    Nj = y(1:6);                                                                       %mol/s

    %Equações auxiliares
    switch cattype
        case('A')
            catid = 1;
        case('B')
            catid = 2;
    endswitch
    switch cateffect
        case('sim')
            Eta = eta(catid,:);                                                        %Adimensional
        case('nao')
            Eta = 1;                                                                   %Adimensional
    endswitch
    N  = sum(Nj);                                                                      %mol/s
    yj = Nj/N;                                                                         %Adimensional
    PE = yj(1)*(P/100000);                                                             %bar
    PO = yj(2)*(P/100000);                                                             %bar
    k  = A.*exp(-Ea/(R*T));                                                            %mol/g.s.bar^(1+n)
    rW = Eta.*k.*PE.*(PO.^n)./((1+KE.*PE).^2);                                         %mol/g.s
    r  = rhoB*rW;                                                                      %mol/m^3.s
    Rj = nu'*r';                                                                       %mol/m^3.s
    c  = P/(R*T);                                                                      %mol/m^3
    Q  = N/c;                                                                          %m^3/s

    %EDOs
    dNj = Rj';                                                                         %mol/m^3.s
    switch Ttype
        case('constante')
            dTa = 0;                                                                   %K/m^3
            dT  = 0;                                                                   %K/m^3
        case('variavel')
            [Cpj,Hj,Sj] = nist(T,cNIST);                                               %J/mol.K, kJ/mol, J/mol.K
            DelH        = nu*Hj*1000;                                                  %J/mol
            Nj_Cpj      = sum(Nj.*Cpj);                                                %J/K.s
            switch Tvartype
                case('adiabatico')
                    q   = 0;                                                           %J/m^3.s
                    dTa = 0;                                                           %K/m^3
                case('autotermico')
                    [Cpja,Hja,Sja] = nist(Ta,cNIST);                                   %J/mol.K, kJ/mol, J/mol.K
                    Njf_Cpja       = sum(Njf'.*Cpja);                                  %J/K.s
                    Rr             = D/2;                                              %m
                    q              = (2/Rr)*U*(Ta-T);                                  %J/m^3.s
                    dTa            = q/Njf_Cpja;                                       %K/m^3
            endswitch
            dT = (-sum(DelH.*r')+q)/Nj_Cpj;                                            %K/m^3
    endswitch
    switch Ptype
        case('constante')
            dP = 0;                                                                    %Pa/m^3
        case('variavel')
            Dp       = dp(catid);
            [Mj,muj] = perry(T,cPerry);                                                %g/mol, Pa.s
            M        = sum(yj.*Mj);                                                    %g/mol
            mu       = sum(muj.*yj.*sqrt(Mj))/sum(yj.*sqrt(Mj));                       %Pa.s
            # mu       = wilke(yj,muj,Mj);                                               %Pa.s
            rho      = (P/(R*T))*(M/1000);                                             %kg/m^3
            dP       = -(1-eB)/(Dp*eB^3)*(Q/(Ac^2))*(150*(1-eB)*mu/Dp+(7/4)*rho*Q/Ac); %Pa/m^3
    endswitch

    %Vetor de saída
    dydx = [dNj dT dP dTa]';
endfunction
