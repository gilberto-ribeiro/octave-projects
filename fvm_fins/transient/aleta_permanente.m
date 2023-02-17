function [x,T] = aleta_permanente(n)
	global L P Ac Tb Tinf k h
	m2 = (h*P)/(k*Ac);
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
		endif
			aP     = aW+aE-Sp;
			A(i,i) = aP;
			B(i)   = Su;
	endfor
	T = A\B';
endfunction
