% Parâmetros de entrada
theta = 1;
#n     = 5;
#dt    = 1;
tol   = 1E-3;
% Saída
for n = [5 10]
	for dt = [0.05]
		name = sprintf('theta-%.1f_n-%d_dt-%.4f_tol-%.1E',theta,n,dt,tol);
		load(sprintf('%s.mat',name));
		residuo = [t r];
		dlmwrite(sprintf('residuo_n-%d_dt-%.2f',n,dt),residuo,'delimiter','\t','newline','\n','precision','%.4f')
	endfor
endfor
