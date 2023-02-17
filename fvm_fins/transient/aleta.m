clear all, close all, clc, clf
% Parâmetros globais
global L P Ac Tb Tinf cp rho k h
L    = 1;             %m
P    = 0.4;           %m
Ac   = 0.01;          %m2
Tb   = 300;           %ºC
Tinf = 20;            %ºC
cp   = 1000;          %J/kg.K
rho  = 7800;          %kg/m3
k    = 100;           %W/m.K
h    = 10;            %W/m2.K
% Parâmetros de entrada
theta = 1;
tol   = 1E-3;
% Saída
for n = [5 10]
	for dt = [1000 500 200 100 50 20 10 5 2 1 0.5 0.2 0.1 0.05]
		tic
		[xss,Tss] = aleta_permanente(n);
		[x,t,T,r] = aleta_transiente(theta,n,dt,tol,Tss);
		elapsed_time = toc
		name = sprintf('theta-%.1f_n-%d_dt-%.4f_tol-%.1E_tf-%.4f',theta,n,dt,tol,t(end));
		save(sprintf('%s.mat',name));
	endfor
endfor
