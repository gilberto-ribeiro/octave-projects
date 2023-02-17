% Parâmetros globais
global L P Ac Tb Tinf k h m2
L    = 1;          %m
P    = 0.4;        %m
Ac   = 0.01;       %m2
Tb   = 300;        %ºC
Tinf = 20;         %ºC
k    = 100;        %W/m.K
h    = 10;         %W/m2.K
m2 = (h*P)/(k*Ac);
% Função para a solução numérica do perfil de temperatura
function [x,T,A,B] = aleta_numerico(n)
	global L P Ac Tb Tinf k h m2
	dx = L/n;
	x  = linspace(dx/2,L-dx/2,n)';
	A  = zeros(n,n);
	for i = 1:n
		if i == 1
			aW       = 0;
			aE       = 1/dx;
			Sp       = -m2*dx-2/dx;
			Su       = m2*Tinf*dx+2*Tb/dx;
			A(i,i+1) = -aE;
		elseif i == n
			aW       = 1/dx;
			aE       = 0;
			Sp       = -m2*dx-1/(k/h+dx/2);
			Su       = m2*Tinf*dx+Tinf/(k/h+dx/2);
			A(i,i-1) = -aW;
		else
			aW       = 1/dx;
			aE       = 1/dx;
			Sp       = -m2*dx;
			Su       = m2*Tinf*dx;
			A(i,i+1) = -aE;
			A(i,i-1) = -aW;
		end
			aP     = aW+aE-Sp;
			A(i,i) = aP;
			B(i)   = Su;
	end
	B = B';
	T = A\B;
	% x(end+1) = L;
	% T(end+1) = (T(end)+((h/k)*(dx/2))*Tinf)/(1+(h/k)*(dx/2));
end
% Função para a solução analítica do perfil de temperatura
function T = aleta_analitico(x)
	global L Tb Tinf k h m2
	m           = sqrt(m2);
	theta_b     = Tb-Tinf;
	theta_ratio = (cosh(m*(L-x))+(h/(m*k))*sinh(m*(L-x)))./(cosh(m*L)+(h/(m*k))*sinh(m*L));
	theta       = theta_b*theta_ratio;
	T           = theta+Tinf;
end
% Saída
n1            = 5;
n2            = 10;
[x1,T1,A1,B1] = aleta_numerico(n1);
[x2,T2,A2,B2] = aleta_numerico(n2);
x             = [0:0.001:L]';
T             = aleta_analitico(x);
desvio        = @(n,a) abs(n-a)./a*100;
% Gráficos
fig1 = figure(1);
plot(x1,T1,'+',x2,T2,'x',x,T)
legend(sprintf('Solução numérica, $n=%d$',n1),sprintf('Solução numérica, $n=%d$',n2),'Solução analítica')
legend box off
xlabel('$x$ (m)'), ylabel('$T$ ($^\circ$C)')
print(fig1,'fig_gr_perfil_aleta_regime_permanente','-dpdflatexstandalone'), hold off
system('pdflatex fig_gr_perfil_aleta_regime_permanente')
fig2 = figure(2)
plot(x1,desvio(T1,aleta_analitico(x1)),'+')
hold on
plot(x2,desvio(T2,aleta_analitico(x2)),'x')
legend(sprintf('$n=%d$',n1),sprintf('$n=%d$',n2))
legend box off
xlabel('$x$ (m)'), ylabel('Desvio relativo (\%)')
print(fig2,'fig_gr_desvio_aleta_regime_permanente','-dpdflatexstandalone'), hold off
system('pdflatex fig_gr_desvio_aleta_regime_permanente')
system('rm *inc.pdf *.aux *.log *.tex')