clf
fig1 = figure(1);
subplot(3,2,1:4)
plot(z,nj(:,1:4),'linewidth',1), hold on
plot(z,nj(:,5),'--','linewidth',1)
legend('Etileno','Oxigênio','Óxido de etileno','Dióxido de carbono','Água');
legend boxoff
axis([0 max(z) 0 max(nj(1))])
if nC == 1
    if cateffect == 'sim'
        title(sprintf('Produção de óxido de etileno, %.2f kmol/h (W_%s=%.2f ton e N_f=%.2f kmol/h)',NEO,cattype,W,NF))
        else
        title(sprintf('Produção de óxido de etileno, %.2f kmol/h (W=%.2f ton e N_f=%.2f kmol/h)',NEO,W,NF))
    endif
    else
    if cateffect == 'sim'
        title(sprintf('Produção de óxido de etileno em uma das %d linhas, total de %.2f kmol/h  (W_%s=%.2f ton e N_f=%.2f kmol/h)',nC,NEO,cattype,W,NF))
        else
        title(sprintf('Produção de óxido de etileno em uma das %d linhas, total de %.2f kmol/h  (W=%.2f ton e N_f=%.2f kmol/h)',nC,NEO,W,NF))
    endif
endif
if nR == 1
    xlabel(sprintf('Comprimento do reator com %.2f m de diâmetro (m)',D))
    else
    xlabel(sprintf('Comprimento total dos %d reatores com %.2f m de diâmetro (m)',nR,D))
endif
ylabel('Vazão molar (kmol/h)')
subplot(3,2,5)
[ax,h1,h2] = plotyy(z(2:end),S,z,X(:,2));
set(h1,'linewidth',1)
set(h2,'linewidth',1)
axis([0 max(z)])
xlabel('z (m)')
ylabel(ax(1),'S_{C_2H_4O/CO_2}')
ylabel(ax(2),'X_{O_2}')
title(sprintf('Seletividade e conversão (S=%.2f e X_{O_2}=%.2f)',S(end),X(end,2)))
subplot(3,2,6)
[ax,h1,h2] = plotyy(z,T,z,P);
set(h1,'linewidth',1)
set(h2,'linewidth',1)
axis([0 max(z)])
xlabel('z (m)')
ylabel(ax(1),'T (°C)')
ylabel(ax(2),'P (bar)')
title(sprintf('Temperatura e pressão (T_{max}=%.2f °C e \\DeltaP=%.2f bar)',max(T),P(end)-P(1)))
print -F:10 -svgconvert -dpdfcrop fig_gr_multiplot_octave
print -F:8 -dpng fig_gr_multiplot_octave
print(fig1,sprintf('fig_gr_%s.png',name),'-F:8')
print -F:8 -dsvg fig_gr_multiplot_octave
hold off
