function retval = bissec(f,a,b,tolmax,imax);
  #Função para a resolução de equações não lineares pelo Método da Bissecção.
  #
  #retval = bissec(f,a,b,tolmax,imax)
  #
  #f é a função a ser resolvida: f(x) = 0.
  #a e b são os limites do intervalo.
  #tolmax é a tolerância máxima determinada por abs(b-a)/2.
  #imax é o número máximo de iterações até a convergência.
  #
  #retval{1} retorna a raiz da equação.
  #retval{2} retorna a matriz contendo os valores de a, b, x, f(x) e tolerância
  #a cada iteração.
  #
  #Desenvolvida por: Gilberto Ribeiro Pinto Júnior.
  #Última atualização: 29/01/2023.
  a(1) = a;
  b(1) = b;
  if f(a)*f(b) > 0
    retval{1} = NaN;
    retval{2} = NaN;
  else
    for i = 1:imax
      x(i) = (a(i)+b(i))/2;
      if f(x(i))*f(a(i)) < 0
        a(i+1) = a(i);
        b(i+1) = x(i);
      else
        a(i+1) = x(i);
        b(i+1) = b(i);
      endif
      tol(i) = abs(b(i)-a(i))/2;
      if tol(i) <= tolmax
        imax = i;
        break
      endif
    endfor
    retval{1} = x(imax);
    retval{2} = [1:imax; a(1:imax); b(1:imax); x; f(x); tol]';
  endif
endfunction
