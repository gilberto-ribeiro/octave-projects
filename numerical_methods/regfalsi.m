function retval = regfalsi(f,a,b,err,imax);
  #Função para a resolução de equações não lineares pelo Método Regula Falsi.
  #
  #retval = regfalsi(f,a,b,err,imax)
  #
  #f é a função a ser resolvida: f(x) = 0.
  #a e b são os limites do intervalo.
  #err é erro relativo estimado determinado por abs((x(i)-x(i-1))/x(i-1)).
  #imax é o número máximo de iterações até a convergência.
  #
  #retval{1} retorna a raiz da equação.
  #retval{2} retorna a matriz contendo os valores de a, b, x, f(x) e erro
  #relativo estimado a cada iteração.
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
      x(i) = (a(i)*f(b(i))-b(i)*f(a(i)))/(f(b(i))-f(a(i)));
      if f(x(i))*f(a(i)) < 0
        a(i+1) = a(i);
        b(i+1) = x(i);
      else
        a(i+1) = x(i);
        b(i+1) = b(i);
      endif
      if i == 1
        errel(i) = NaN;
      else
        errel(i) = abs((x(i)-x(i-1))/x(i-1));
      endif
      if errel(i) <= err
        imax = i;
        break
      endif
    endfor
    retval{1} = x(imax);
    retval{2} = [1:imax; a(1:imax); b(1:imax); x; f(x); errel]';
  endif
endfunction
