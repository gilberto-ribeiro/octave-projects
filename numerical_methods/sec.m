function retval = sec(f,x1,x2,err,imax);
  #Função para a resolução de equações não lineares pelo Método da Secante.
  #
  #retval = sec(f,x1,x2,err,imax)
  #
  #f é a função a ser resolvida: f(x) = 0.
  #x1 e x2 são os pontos iniciais na vizinhança da raiz.
  #err é erro relativo estimado determinado por abs((x(i)-x(i-1))/x(i-1)).
  #imax é o número máximo de iterações até a convergência.
  #
  #retval{1} retorna a raiz da equação.
  #retval{2} retorna a matriz contendo os valores de x, f(x) e erro relativo
  #estimado a cada iteração.
  #
  #Desenvolvida por: Gilberto Ribeiro Pinto Júnior.
  #Última atualização: 29/01/2023.
  x(1) = x1;
  x(2) = x2;
  for i = 1:imax
    if i > 1
      df = (f(x(i))-f(x(i-1)))/(x(i)-x(i-1));
      x(i+1) = x(i)-f(x(i))/df;
    endif
    if i > 3
      errel(i) = abs((x(i)-x(i-1))/x(i-1));
    else
      errel(i) = NaN;
    endif
    if errel(i) <= err
      imax = i;
      break
    endif
  endfor
  retval{1} = x(imax);
  retval{2} = [-1:imax-2; x(1:imax); f(x(1:imax)); errel]'(3:imax,:);
endfunction
