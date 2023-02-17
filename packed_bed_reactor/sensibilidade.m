clear all, close all, clc, clf

X1  = [0.5:0.05:1.25];
X2  = [6.5:0.25:9.5];
nX1 = length(X1);
nX2 = length(X2);

count = 1;
tic
for it1 = 1:nX1
    for it2 = 1:nX2
        disp(sprintf('%d de %d: X1(%d-%d) = %.2f, X2(%d-%d) = %.2f',count,nX1*nX2,it1,nX1,X1(it1),it2,nX2,X2(it2)))
        pbr
        YY{it1,it2} = PBR;
        clear PBR
        count++;
    endfor
endfor
toc
clear it1 it2 count

for it1 = 1:nX1
    for it2 = 1:nX2
        Y1(it1,it2) = YY{it1,it2}(3,end);      
        Y2(it1,it2) = YY{it1,it2}(12,end);
        Y3(it1,it2) = YY{it1,it2}(11,end);
        Y4(it1,it2) = sum(YY{it1,it2}(16,:));
        Y5(it1,it2) = max(YY{it1,it2}(8,:));
        Y6(it1,it2) = YY{it1,it2}(15,end);
    endfor
endfor

[XX1,XX2] = meshgrid(X1,X2);

name_X{1} = 'D (m)';
name_X{2} = 'L (m)';
name_Y{1} = 'Vazão de C_2H_4O (kmol/h)';
name_Y{2} = 'Seletividade';
name_Y{3} = 'Conversão de O_2';
name_Y{4} = 'Temp. máxima (°C)';
Yplot{1} = Y1;
Yplot{2} = Y2;
Yplot{3} = Y3;
Yplot{4} = Y5;
fig_S1 = figure(1);
for it = 1:4
    subplot(2,2,it)
    surf(XX1,XX2,Yplot{it}')
    colormap(jet)
    axis([X1(1) X1(end) X2(1) X2(end)])
    xlabel(name_X{1})
    ylabel(name_X{2})
    zlabel(name_Y{it})
endfor
print -dpng -F:10 fig_gr_sensibilidade
hold off

print(fig_S1,'fig_gr_sensibilidade','-dpdflatexstandalone','-F:10');
system('pdflatex fig_gr_sensibilidade');
system('rm *.aux *.log *.tex *-inc.pdf');

# Legenda
#  1 - Vazão molar de Etileno
#  2 - Vazão molar de Oxigênio
#  3 - Vazão molar de Óxido de Etileno
#  4 - Vazão molar de Dióxido de Carbono
#  5 - Vazão molar de Água
#  6 - Vazão molar de Nitrogênio
#  7 - Temperatura na entrada do reator
#  8 - Temperatura na saída do reator
#  9 - Pressão na saída do reator
# 10 - Conversão de Etileno
# 11 - Conversão de Oxigênio
# 12 - Seletividade
# 13 - Comprimento do reator
# 14 - Razão entre comprimento e diâmetro
# 15 - Volume do reator
# 16 - Massa de catalisador no reator
