function T = aleta_analitico(x)
	global L P Ac Tb Tinf k h
	m2          = (h*P)/(k*Ac);
	m           = sqrt(m2);
	theta_b     = Tb-Tinf;
	theta_ratio = (cosh(m*(L-x))+(h/(m*k))*sinh(m*(L-x)))./(cosh(m*L)+(h/(m*k))*sinh(m*L));
	theta       = theta_b*theta_ratio;
	T           = theta+Tinf;
endfunction
