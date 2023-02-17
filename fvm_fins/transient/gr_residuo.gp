set logsc y
set grid
set xlabel 'Tempo final, $t_{\mathrm{ss}}$ (s)'
set ylabel 'Resíduo ($^\circ$C)'
set t tikz standalone
set o 'fig_gr_residuo.tex'
plot 'residuo_n-5_dt-0.10' u 1:2 t '$n=5$' w l dt 1, \
'residuo_n-10_dt-0.10' u 1:2 t '$n=10$' w l dt 2
set t qt
