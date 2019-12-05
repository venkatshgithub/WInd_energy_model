function plot_monthly_factors(monthly_resource, monthly_demand)

%monthly_factors.(intermit or storage).(avail or cap)
fsize=20;
lsize=5;

filettl = @(ttl) [ttl,'.png'];
legendstr = {'Proposed Cycle','Wind-Only','Solar-Only'};


figure(1)
ttl = 'Power Availability Factor';
plot(monthly_resource.storage.avail, 'LineWidth',lsize)
hold on
plot(monthly_resource.wind.avail, 'LineWidth',lsize)
plot(monthly_resource.solar.avail, 'LineWidth',lsize)
hold off
legend(legendstr,'Location','SouthWest');
monthaxes(fsize,12)
ylabel(ttl)
xlabel('Month')
set(gcf, 'Position',  [100, 100, 1000, 800])
saveas(gcf, 'Power Availability Factor Comparison _othert.png')


figure(2)
ttl = 'Demand-Met Factor';
plot(monthly_demand.storage.avail, 'LineWidth',lsize)
hold on
plot(monthly_demand.wind.avail, 'LineWidth',lsize)
plot(monthly_demand.solar.avail, 'LineWidth',lsize)
hold off
legend(legendstr,'Location','SouthWest');
xlim([1 12])
monthaxes(fsize,12)
ylabel(ttl)
xlabel('Month')
set(gcf, 'Position',  [100, 100, 1000, 800])
saveas(gcf, 'Demand-Met Factor Comparison_othert.png')
