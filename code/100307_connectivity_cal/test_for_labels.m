x = 1:8;
subplot(3,2,1)

plot(x)

title('默认格式')

subplot(3,2,2)

plot(x)

set(gca,'xtick',[1 3 6 8]);

set(gca,'ytick',[]);

title('X自定义间隔，Y关闭')

subplot(3,2,3)

plot(x)

set(gca,'xtick',[1 3 6 8]);

set(gca,'xticklabel',sprintf('.4f|',get(gca,'xtick')))

set(gca,'ytick',[2 4 5 7]);

set(gca,'yticklabel',{'Two','Four','Five','Seven'});

title('XY自定义间隔、精度及显示方式')

subplot(3,2,4)

plot(x)

set(gca,'xminortick','on');%style 5

set(gca,'ticklength',[0.05 0.025]);

set(gca,'tickdir','out');

title('XY坐标刻度显示方式')

subplot(3,2,5)

plot(x)

set(gca,'xtick',[min(x) (max(x)+min(x))/2 max(x)]);

set(gca,'ytick',[min(x) (max(x)+min(x))/2 max(x)]);

title('论文中常用的标准3点式显示')

x=20:10:20000;

y=rand(size(x));

subplot(3,2,6)

semilogx(x,y);

set(gca,'XLim',[20 20000]);

set(gca,'XMinorTick','off');

set(gca,'XTick',[20 31.5 63 125 250 500 1000 2000 4000 8000 16000]);

set(gca,'XGrid','on');

set(gca,'XMinorGrid','off');

title('自定义网格显示')

%%%%%%%%%%%%%%%%%%%%%%

%顺便附上可以格式化坐标刻度的程序段

x=get(gca,'xlim');

y=get(gca,'ylim');

set(gca,'xtick',[x(1) (x(1)+x(2))/2 x(2)]);

set(gca,'ytick',[y(1) (y(1)+y(2))/2 y(2)]);