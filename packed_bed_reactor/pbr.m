%Preparação do Octave
clear all, close all, clc, clf

%Parâmetros globais
parametros

global D Ac Ttype Tvartype Ptype cateffect cattype Njf

%Parâmetros de entrada
Ttype     = 'variavel'; %'constante', 'variavel'
Tvartype  = 'adiabatico'; %'isotermico', 'adiabatico', 'autotermico'
Ptype     = 'variavel'; %'constante', 'variavel'
cateffect = 'sim'; %'sim','nao'
cattype   = 'B'; %'A', 'B'

L  = [13];%m
D  = 1.15; %m
nC = 4;
NF = 12000; %kmol/h

%Parâmetros calculados
nR    = length(L);
Ac    = pi*(D^2)/4; %m^2
ratio = L/D;

%Intervalo de integração
VR  = Ac*L; %m^3
h   = 0.01; %m^3

%Condições iniciais
yjf = [0.25 0.10 0 0 0 0.65];
Nf  = NF*(1000/3600)/nC;      %mol/s
Njf = yjf*Nf;                 %mol/s
Tf  = 250+273.15;             %K
Pf  = 25*100000;              %Pa
Taf = Tf;
IC  = [Njf Tf Pf Taf]';

%Eventos
function [value,isterminal,direction] = myevents(x,y)
    value      = y(2);
    isterminal = 1;
    direction  = 0;
endfunction
options = odeset('Events',@myevents);

%Solver
tic
xout = 0; yout = zeros(1,length(IC));
for i = 1:nR;
    int{i}= [0:h:VR(i)];
    [x y] = ode45(@edos,int{i},IC,options);
    xR{i} = real(x); yR{i} = real(y);
    IC    = [y(end,1:6) Tf y(end,8) Taf];
    xout  = [xout' xout(end)+xR{i}']';
    yout  = [yout' yR{i}']';

    id(i)       = i;
    Vout(i)     = xR{i}(end);                         %m^3
    Nout(i,1:6) = yR{i}(end,1:6);                     %mol/s
    Tin(i)      = yR{i}(1,7);                         %K
    Tout(i)     = yR{i}(end,7);                       %K
    Pout(i)     = yR{i}(end,8);                       %Pa
    Taout(i)    = yR{i}(end,9);                       %K
    Xout(i,1:2) = (Njf(1:2)-Nout(i,1:2))./(Njf(1:2));
    Sout(i)     = Nout(i,3)./Nout(i,4);
endfor
xout(1) = []; yout(1,:) = [];
toc

%Imprimir
PBR = [Nout*3.6 Tin'-273.15 Tout'-273.15 Pout'*1E-5 Xout Sout' L' ratio' Vout' rhoB*Vout'*1E-6]';
NEO = nC*PBR'(end,3);
W   = nC*sum(PBR'(:,end));

%Valores de saída
V  = xout;             %m^3
Nj = yout(:,1:6);      %mol/s
T  = yout(:,7)-273.15; %°C
P  = yout(:,8)/100000; %bar
Ta = yout(:,9)-273.15; %°C

%Gráficos
z  = V/Ac;           %m
nj = Nj*(3600/1000); %kmol/h
X  = (Njf-Nj)./(Njf);
S  = Nj(2:end,3)./Nj(2:end,4);

Lstr = '['; for i=1:nR Lstr = sprintf('%s%.2f-',Lstr,L(i)); endfor; Lstr(1) = []; Lstr(end) = [];
name = sprintf('yE-%.2f_yO-%.2f_yI-%.2f_Tf-%.2f_Pf-%.2f_Nf-%.2f_L-%s_D-%.2f_nR-%d_nC-%d_T-%s-%s_P-%s_Cat-%s-%s',yjf(1),yjf(2),yjf(6),Tf-273.15,Pf*1E-5,NF,Lstr,D,nR,nC,Ttype,Tvartype,Ptype,cattype,cateffect);

save(sprintf('%s.mat',name))
dlmwrite(sprintf('PBR_%s',name),PBR,'delimiter',' & ','newline','\n','precision','%.2f')
dlmwrite(sprintf('PBR'),PBR,'delimiter','\t','newline','\n','precision','%.2f')

graficos_latex
graficos_octave
graficos_autotermico

clc

PBR
Tmax = PBR(8,:)'
disp(sprintf('Massa total de catalisador: %.2f ton.',W))
disp(sprintf('Produção total de óxido de etileno: %.2f kmol/h.',NEO))

clf, close all
