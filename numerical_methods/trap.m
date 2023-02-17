function retval = trap(f,a,b,h);
  #Função para a integração numérica pelo Método Trapezoidal.
  #
  #retval = trap(f,a,b,h)
  #
  #f é a função a ser integrada (integrando).
  #a e b são os limites de integração.
  #h é o tamanho de cada subintervalo.
  #
  #retval{1} retorna o valor da integral numérica.
  #
  #Desenvolvida por: Gilberto Ribeiro Pinto Júnior.
  #Última atualização: 30/01/2023.
  x = a:h:b;
  N = length(x)-1;
  Itot = (h/2)*(f(a)+f(b))+h*sum(f(x(2:N)));
  retval{1} = Itot;
endfunction
