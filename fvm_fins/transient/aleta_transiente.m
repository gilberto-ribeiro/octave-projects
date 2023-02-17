function [x,t,T,r] = aleta_transiente(theta,n,dt,tol,Tss)
	global L P Ac Tb Tinf cp rho k h
	n2     = (h*P)/(cp*Ac);
	dx     = L/n;
	x      = linspace(dx/2,L-dx/2,n)';
	A      = zeros(n,n);
	j      = 1;
	t(j)   = 0;
	T0     = Tinf*ones(n,1);
	T(:,j) = T0;
	res    = @(a,b) max(abs(a-b));
	r(j)   = res(T(:,j),Tss);
	while res(T(:,j),Tss) > tol
		for i = 1:n
			if i == 1
				aW       = 0;
				aE       = k/(cp*dx);
				Sp       = -n2*dx-2*k/(cp*dx);
				Su       = n2*Tinf*dx+2*k/(cp*dx)*Tb;
				Tw0      = 0;
				Te0      = T(i+1,j);
				A(i,i+1) = -theta*aE;
			elseif i == n
				aW       = k/(cp*dx);
				aE       = 0;
				Sp       = -n2*dx-2*h*k/(cp*(2*k+h*dx));
				Su       = n2*Tinf*dx+2*h*k/(cp*(2*k+h*dx))*Tinf;
				Tw0      = T(i-1,j);
				Te0      = 0;
				A(i,i-1) = -theta*aW;
			else
				aW       = k/(cp*dx);
				aE       = k/(cp*dx);
				Sp       = -n2*dx;
				Su       = n2*Tinf*dx;
				Tw0      = T(i-1,j);
				Te0      = T(i+1,j);
				A(i,i+1) = -theta*aE;
				A(i,i-1) = -theta*aW;
			endif
				aP0    = rho*dx/dt;
				aP     = aP0+theta*(aW+aE-Sp);
				Tp0    = T(i,j);
				A(i,i) = aP;
				B(i)   = (1-theta)*aW*Tw0+(1-theta)*aE*Te0+(aP0-(1-theta)*(aW+aE-Sp))*Tp0+Su;
		endfor
		t(j+1)   = t(j)+dt;
		T(:,j+1) = A\B';
		r(j+1)   = res(T(:,j+1),Tss);
		disp(sprintf('n = %d | dt = %.4f | r = %.4E | t = %.4f',n,dt,r(j+1),t(j+1)))
		j++;
	endwhile
	r = r';
	t = t';
	T = T';
endfunction
