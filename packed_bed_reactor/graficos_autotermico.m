if Tvartype == 'autotermico'
    fig2 = figure(2);
    plot(z,T,'linewidth',1,z,Ta,'linewidth',1)
    title('Perfil de temperatura no reator autotérmico')
    legend('$T$','$T_a$')
    legend boxoff
    ylabel(sprintf('Temperatura ($^\\circ$C)'))
    xlabel(sprintf('Comprimento do reator com %.2f~m de diâmetro (m)',D))
    print(fig2,sprintf('fig_gr_AUTOTERMICO_%s.tex',name),'-dpdflatexstandalone');
    system(sprintf('pdflatex fig_gr_AUTOTERMICO_%s.tex',name));
    system('rm *.aux *.log *.tex *-inc.pdf');
    hold off
    fig2 = figure(2);
    plot(z,T,'linewidth',1,z,Ta,'linewidth',1)
    title('Perfil de temperatura no reator autotérmico')
    legend('T','T_a')
    legend boxoff
    ylabel(sprintf('Temperatura (°C)'))
    xlabel(sprintf('Comprimento do reator com %.2f m de diâmetro (m)',D))
    print(fig2,sprintf('fig_gr_AUTOTERMICO_%s.png',name));
    hold off
endif
