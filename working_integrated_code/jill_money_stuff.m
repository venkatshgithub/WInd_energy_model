% Call this script as a part of JillStuff, after jill_intermit_stuff just
% put in another function to declutter

demand_met_kwh=demand_factors.demand_met_kwh;
revenue_usd_year = demand_met_kwh.*power_prices_kwh;
revenue_usd_total = sum(revenue_usd_year);

ic.rate_kwh.wind=1877;
ic.rate_kwh.solar=12558/6;

vc.year_kwh.wind=39.7;
vc.year_kwh.solar=65.7;

cap_kw.wind = 500;
cap_kw.solar = mean(solar_year);

ic.total.wind=ic.rate_kwh.wind*cap_kw.wind;
ic.total.solar=ic.rate_kwh.solar*cap_kw.solar;
vc.year.wind=vc.year_kwh.wind*cap_kw.wind;
vc.year.solar=vc.year_kwh.solar*cap_kw.solar;
vc.month.wind=vc.year.wind/12;
vc.month.solar=vc.year.solar/12;
vc.hour.wind=vc.year.wind/8760;
vc.hour.solar=vc.year.wind/8760;

money_history = @(ic,hvc,hrev) cumsum(hrev-hvc)-ic;

mhist.wind.hourly = money_history(ic.total.wind, vc.hour.wind, revenue_usd_year);
mhist.solar.hourly = money_history(ic.total.solar, vc.hour.solar, revenue_usd_year);

fsize=20;

figure(3)
plot(mhist.wind.hourly)
monthaxes(fsize,8760)