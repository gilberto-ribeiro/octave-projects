global cNIST cPerry nu A Ea R KE n eB rhop dp rhoB eta U

%DADOS TERMODINÂMICOS E TERMOFÍSICOS

%Dados provenientes do NIST para o cálculo de Cp, H e S
%                A         B         C         D         E         F        G
cNIST = [ -6.38788  184.4019 -112.9718  28.49593   0.31554  48.17332 163.1568;  %C2H4
          31.32234 -20.23531  57.86644 -36.50624 -0.007374 -8.903471 246.7945;  %O2
         -23.25802  275.6997 -188.9729   51.0335   0.38693 -55.09156 142.7777;  %C2H4O
          24.99735  55.18696 -33.69137  7.948387 -0.136638 -403.6075 228.2431;  %CO2
            30.092  6.832514  6.793435  -2.53448  0.082139  -250.881 223.3967;  %H20
          28.98641  1.853978 -9.647459  16.63537  0.000117 -8.671914 226.4168]; %N2

%Dados provenientes do Perry para a massa molar e a viscosidade dinâmica
%               Mj        C1      C2     C3 C4
cPerry = [28.05316 2.0789E-6  0.4163  352.7  0;  %C2H4
           31.9988 1.1010E-6  0.5634   96.3  0;  %O2
          44.05256 4.3403E-8 0.94806      0  0;  %C2H4O
           44.0095 2.1480E-6    0.46    290  0;  %CO2
          18.01528 1.7096E-8  1.1146      0  0;  %H20
           28.0134 6.5592E-7  0.6081 54.714  0]; %N2

%PARÂMETROS CINÉTICOS

%     C2H4   O2 C2H4O CO2 H2O N2
nu = [  -1 -0.5     1   0   0  0;  %Adimensional
        -1   -3     0   2   2  0];

A  = [1.33E2 1.80E3];              %mol/g.s.bar^(1+n)
Ea = [60.7E3 73.2E3];              %J/mol
R  = 8.3145;                       %J/mol.K ou Pa.m^3/mol.K
KE = [6.50 4.33];                  %bar^(-1)
n  = [0.58 0.30];

%PARÂMETROS DO CATALISADOR

eB   = 0.60;
rhop = 780;                        %kg/m^3
esf  = [1 0.8];                    %Adimensional
dp   = esf.*[2 3]/100;             %m
rhoB = (1-eB)*rhop*1000;           %g/m^3
eta  = [0.5957 0.8034              %Adimensional
        0.6950 0.4946];
cost = [95 125];                   %US$/kg

U    = 2271.3;                     %J/m^2.s.K
