%Preparação do Octave
clear all, close all, clc, clf, warning off

%Parâmetros globais
global D Kd kf qm R V v E C0 c0 n r hr solver

D  = 4.5E-12; %m^2/s
Kd = 0.019;   %kg/m^3
kf = 4.0E-6;  %m/s
qm = 40;      %kg/m^3
R  = 45E-6;   %m
V  = 2.5E-6;  %m^3
v  = 0.5E-6;  %m^3
E  = 0.955;   %Adimensional
C0 = 0.50;    %kg/m^3
c0 = 0;       %kg/m^3

%Parâmetros para discretização
n  = 101;
r  = linspace(0,1,n);
hr = (1-0)/(n-1);

%Intervalo de integração
t0  = 0;
tf  = (D/(R^2))*2000;
ht  = (D/(R^2))*0.01;
int = [t0 tf];

%Condições iniciais
c0adm = zeros(1,n);
C0adm = 1;
IC    = [c0adm C0adm];

%Solver
tic
solver = 'rk4';
switch solver
    case('rk4')
    [tadm, cadm] = rk4(@concentracao_edos,int,IC,ht);
    case('ode45')
    [tadm, cadm] = ode45(@concentracao_edos,t0:ht:tf,IC');
endswitch
elapsed_time = toc

%Saída
global t c C q
t = ((R^2)/D)*tadm;         %s
c = (C0-c0)*cadm(:,1:n)+c0; %mg/ml
C = (C0-c0)*cadm(:,n+1)+c0; %mg/ml
q = (qm*c)./(Kd+c);         %mg/ml

save concentracao.mat
