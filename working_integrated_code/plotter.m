function plotter(data,ttle,smooth_fac)
fsize = 28;
lw = 3;
h = figure;
plot(smooth(data,smooth_fac,'rloess')*0.001,'LineWidth',lw);
ylabel('Power in kW','FontSize',fsize);
set(gca,'xtick',linspace(1,length(data),12),'xticklabel',...
     {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
     'FontSize', fsize) ;
title(ttle,'Fontsize',fsize);
xlabel('Month')
set(gcf, 'Position',  [100, 100, 1200, 1150])
saveas(gcf,strcat(ttle,'.eps'));

end

