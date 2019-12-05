% Call this script as a part of JillStuff, after jill_intermit_stuff just
% put in another function to declutter

demand_met_kwh=demand_factors.demand_met_kwh;
revenue_usd_year = demand_met_kwh.*power_prices_kwh;
revenue_usd_total = sum(revenue_usd_year);

ic.rate_kwh.wind=2000;
ic.rate_kwh.solar=12558/6;

vc.year_kwh.wind=39.7;
vc.year_kwh.solar=65.7;

cap_kw.wind.GE = 1500;
cap_kw.wind.EWT = 500;
cap_kw.wind.hummer = 50;
cap_kw.solar = mean(solar_year);
cap_kw.overall=cap_kw.wind.(model)+cap_kw.solar;

ic.total.wind=ic.rate_kwh.wind*cap_kw.wind.(model);
ic.total.solar=ic.rate_kwh.solar*cap_kw.solar;
ic.total.total = ic.total.wind+ic.total.solar;

vc.year.wind=vc.year_kwh.wind*cap_kw.wind.(model);
vc.year.solar=vc.year_kwh.solar*cap_kw.solar;
vc.month.wind=vc.year.wind/12;
vc.month.solar=vc.year.solar/12;
vc.hour.wind=vc.year.wind/8760;
vc.hour.solar=vc.year.wind/8760;
vc.hour.total=vc.hour.wind+vc.hour.solar;

ic.total.usc=3636*cap_kw.overall;
ic.total.ctng=978*cap_kw.overall;
ic.total.ngcc=678*cap_kw.overall;
ic.total.angcc=1342*cap_kw.overall;
ic.total.rice=5945*cap_kw.overall;
ic.total.an=4985*cap_kw.overall;

vc.hour.usc=42.1/8760;
vc.hour.ctng=11/8760;
vc.hour.ngcc=6.8/8760;
vc.hour.angcc=6.9/8760;
vc.hour.rice=100.28/8760;
vc.hour.an=110/8760;


% revenue_usd_year=repmat(revenue_usd_year,[7,1]);

money_history = @(ic,hvc,hrev) cumsum(hrev-hvc)-ic;

mhist.cycle.hourly = money_history(ic.total.total, vc.hour.total, revenue_usd_year);
mhist.usc.hourly=money_history(ic.total.usc, vc.hour.usc, revenue_usd_year);
mhist.ctng.hourly=money_history(ic.total.ctng, vc.hour.ctng, revenue_usd_year);
mhist.ngcc.hourly=money_history(ic.total.ngcc, vc.hour.ngcc, revenue_usd_year);
mhist.angcc.hourly=money_history(ic.total.angcc, vc.hour.angcc, revenue_usd_year);
mhist.rice.hourly=money_history(ic.total.rice, vc.hour.rice, revenue_usd_year);
mhist.an.hourly=money_history(ic.total.an, vc.hour.an, revenue_usd_year);

fsize=20;

figure(3)
plot(mhist.cycle.hourly)
monthaxes(fsize,length(revenue_usd_year))

figure(4)
plot(mhist.cycle.hourly)
hold on
plot(mhist.usc.hourly)
plot(mhist.ngcc.hourly)
plot(mhist.angcc.hourly)
plot(mhist.rice.hourly)
plot(mhist.an.hourly)
hold off
legend('Proposed cycle','Ultrasuperitical Coal',...
    'Natural Gas Combined Cycle','Advanced Combustion Turbine',...
    'Reciprocating Internal Combustion Engine','Advanced Nuclear',...
    'Location', 'SouthEast')
monthaxes(fsize,length(revenue_usd_year))