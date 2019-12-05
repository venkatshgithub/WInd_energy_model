function plot_monthly_factors(monthly_factors)

%monthly_factors.(intermit or storage).(avail or cap)
fsize=24;
lsize=5;

figure
ttl = 'Availability Factor';
filettl = [ttl,'.png'];
plot(monthly_factors.storage.avail, 'LineWidth',lsize)
xlim([1 12])
set(gca,'xtick',1:12,'xticklabel',...
     {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
     'FontSize', fsize) 
ylabel(ttl)
xlabel('Month')
saveas(gcf, 'Availability Factor.png')

figure
ttl = 'Capacity Factor';
plot(monthly_factors.storage.capac, 'LineWidth',lsize)
xlim([1 12])
set(gca,'xtick',1:12,'xticklabel',...
     {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
     'FontSize', fsize) 
ylabel(ttl)
xlabel('Month')
saveas(gcf, 'Capacity Factor.png')
