function retval = pfixo(g,xest,err,imax);
  #Função para a resolução de equações não lineares pelo Método do Ponto Fixo.
  #
  #retval = pfixo(g,xest,err,imax)
  #
  #g é a função de iteração, em que: g(x) = x.
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
    x(i+1) = g(x(i));
    f(i) = g(x(i))-x(i);
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
  retval{2} = [0:imax-1; x(1:imax); f(1:imax); errel]';
endfunction
