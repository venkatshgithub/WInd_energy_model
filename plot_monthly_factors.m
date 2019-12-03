function plot_monthly_factors(monthly_factors)

%monthly_factors.(intermit or storage).(avail or cap)

figure
plot(monthly_factors.storage.avail)
set(gca,'xtick',1:12,'xticklabel',...
     {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'}) 