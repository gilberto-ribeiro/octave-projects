reset
set grid
set logsc xy
set xrange [2000:0.02]
#set yrange [138000:146000]
set ylabel '$t_{\mathrm{ss}}-t_{\mathrm{ss},0.05~s}$ (s)'
set xlabel 'Passo de tempo, $\Delta t$ (s)'
set t tikz standalone
set o 'fig_gr_tss_dt.tex'
plot 'tempo_estacionario' u 1:($2-138483.50) t '$n=5$' w p, '' u 1:($3-138160.90) t '$n=10$' w p
set t qt
