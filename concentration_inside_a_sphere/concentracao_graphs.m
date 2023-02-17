clf, hold off
tfdim = tf/(D/(R^2)); htdim = ht/(D/(R^2));
f1 = 100:-10:0; f2 = [t0:100:tfdim]/htdim; f3 = [0:10:100]/htdim; f4 = [600:10:700]/htdim;

m = 1/htdim;
for i = 1:(tfdim+1)
    tplot(i)   = t(m*(i-1)+1);
    Cplot(i)   = C(m*(i-1)+1);
    cplot(i,:) = c(m*(i-1)+1,:);
    qplot(i,:) = q(m*(i-1)+1,:);
endfor

fig1 = figure(1);
plot(tplot,Cplot,'linewidth',1), hold on
for i = 1:10 plot(tplot,cplot(:,f1(i)+1),'linewidth',1), endfor
plot(tplot,cplot(:,1),'linewidth',1)
legend('$C$','$c(\bar{r}=1.00)$','$c(\bar{r}=0.90)$','$c(\bar{r}=0.80)$',
'$c(\bar{r}=0.70)$','$c(\bar{r}=0.60)$','$c(\bar{r}=0.50)$','$c(\bar{r}=0.40)$',
'$c(\bar{r}=0.30)$','$c(\bar{r}=0.20)$','$c(\bar{r}=0.10)$','$c(\bar{r}=0.00)$')
legend boxoff
for i = 99:-1:91 plot(tplot,cplot(:,i+1),'k:','linewidth',0.10) endfor
ylabel('Concentração (mg/ml)'), xlabel('Tempo (s)')
axis([t0 1200 c0(1) C0])
print(fig1,'fig_gr_concentracao_por_tempo','-dpdflatexstandalone'), hold off
system('pdflatex fig_gr_concentracao_por_tempo')

fig2 = figure(2);
plot(r,c(100+1,:),'linewidth',1), hold on
for i = 2:13 plot(r,c(f2(i)+1,:),'linewidth',1), endfor
legend('$t=1$~s','$t=100$~s','$t=200$~s','$t=300$~s','$t=400$~s',
'$t=500$~s','$t=600$~s','$t=700$~s','$t=800$~s','$t=900$~s','$t=1000$~s',
'$t=1100$~s','$t=1200$~s','location','northwest')
legend boxoff
for i = 2:10 plot(r,c(f3(i)+1,:),'k:','linewidth',0.10), endfor
for i = 2:10 plot(r,c(f4(i)+1,:),'k:','linewidth',0.10), endfor
ylabel('Concentração (mg/ml)'), xlabel('Raio adimensionalizado $\left(\bar{r}=\frac{r}{R}\right)$')
axis([r(1) r(end) c0(1) C0])
print(fig2,'fig_gr_perfil_de_concentracao','-dpdflatexstandalone'), hold off
system('pdflatex fig_gr_perfil_de_concentracao')

for i = 1:1200+1
    plot(r,c(100*1*(i-1)+1,:),'linewidth',2)
    title('Perfis de concentração no interior das esferas - 0 a 1200 s.')
    legend(sprintf('t = %04d s',1*(i-1)))
    legend boxoff
    ylabel('Concentração (mg/ml)')
    xlabel('Raio adimensionalizado')
    axis([r(1) r(end) c0(1) C0])
    print(sprintf('fig_anim_c.%04d.png',i),'-dpng')
    disp(1*(i-1))
endfor
system('foamCreateVideo -i fig_anim_c -o movie_anim_c_40fps -f 40')
system('foamCreateVideo -i fig_anim_c -o movie_anim_c_20fps -f 20')
