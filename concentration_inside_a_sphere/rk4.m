function [xout,yout] = rk4(f,int,IC,h)
    %A função rk4 resolve numericamente uma EDO ou um sistema de EDOs pelo método de
    %Runge-Kutta de Quarta Ordem.
    %
    %[VI,VD] = rk4(F,X,Y0,H)
    %VI = Vetor coluna da variável independente.
    %VD = Matriz das variáveis dependentes, cada qual em uma coluna.
    %F  = Função que retorna um vetor linha com os valores do lado direito das EDOs.
    %X  = Vetor do intervalo de integração.
    %Y0 = Vetor das condições iniciais de cada variável.
    %H  = Tamanho do passo de integração.
    x = int(1):h:int(2);
    n = size(x,2);
    if size(IC,1) == 1
        y = IC;
    else
        y = IC';
    endif
    for j=1:n
        yout(j,:) = y;
        k1 = h*f(x(j),y);
        k2 = h*f(x(j)+h/2,y+k1/2);
        k3 = h*f(x(j)+h/2,y+k2/2);
        k4 = h*f(x(j)+h,y+k3);
        y  = y+(k1+2*k2+2*k3+k4)/6;
        disp(x(j))
    endfor
    xout = x';
endfunction
