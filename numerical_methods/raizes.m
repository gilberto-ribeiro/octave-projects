clear all, clc

function retval = multiroots(method,func,a,b);
  inc = 0.1;
  err = 1e-12;
  imax = 100;
  int = a:inc:b;
  for i = 1:length(int)-1
    X(i) = method(func,int(i),int(i+1),err,imax){1};
  endfor
  clear i;
  j = 1;
  for i = 1:length(X)
    if not(isnan(X(i)))
      x(j) = X(i);
      j++;
    endif
  endfor
  retval = x';
endfunction

#f = @(x) cos(x).*cosh(x)+1;
#f = @(x) 1*x.^3+3.8*x.^2-8.6*x-24.4;
f = @(x) x.^4-5.5*x.^3-7.2*x.^2+43*x+36

R = multiroots(@regfalsi,f,-100,100)
