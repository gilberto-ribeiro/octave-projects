set xlabel '$x$ (m)'
set ylabel '$T$ ($^\circ$C)'
set t tikz standalone
set o 'fig_gr_perfil_temperatura.tex'
plot 'T_n-100_dt-1' u 1:2 t '$t=5$~min' w l, \
'' u 1:3 t '$t=15$~min' w l, \
'' u 1:4 t '$t=30$~min' w l, \
'' u 1:5 t '$t=1$~h' w l, \
'' u 1:6 t '$t=2$~h' w l, \
'' u 1:7 t '$t=5$~h' w l, \
'' u 1:8 t '$t=10$~h' w l, \
'' u 1:9 t '$t=t_{\mathrm{ss}}=138048$~s' w l
set t qt
