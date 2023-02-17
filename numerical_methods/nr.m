function retval = nr(f,df,xest,err,imax);
  #Função para a resolução de equações não lineares pelo Método de Newton-Rhapson.
  #
  #retval = nr(f,df,xest,err,imax)
  #
  #f é a função a ser resolvida: f(x) = 0.
  #df é a derivada de f.
  #xest é a estimativa inicial para raiz.
  #err é erro relativo estimado determinado por abs((x(i)-x(i-1))/x(i-1)).
  #imax é o número máximo de iterações até a convergência.
  #
  #retval{1} retorna a raiz da equação.
  #retval{2} retorna a matriz contendo os valores de x, f(x) e erro relativo
  #estimado a cada iteração.
  #
  #Desenvolvida por: Gilberto Ribeiro Pinto Júnior.
  #Última atualização: 30/01/2023.
  x(1) = xest;
  for i = 1:imax
    x(i+1) = x(i)-f(x(i))/df(x(i));
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
  retval{2} = [0:imax-1; x(1:imax); f(x(1:imax)); errel]';
endfunction
