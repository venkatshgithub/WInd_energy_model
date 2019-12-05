load('prices_kwh.mat') %prices_kwh
load('Estimated_Hourly_Demand_MW') %Hourly_Demand MW
load('final_power_output') %watts

power_captured_kwh = final_power_output*1e-3;
power_demand_kwh = meet_factor*Hourly_Demand*1e3;
power_prices_kwh=prices_kwh.yr2017.prices/100;

[resource_factors, demand_met_kwh] = get_avail_cap_factors(...
    power_captured_kwh,power_demand_kwh);
plot_monthly_factors(resource_factors.monthly)

revenue_usd_year = demand_met_kwh.*power_prices_kwh;
revenue_usd_total = sum(revenue_usd_year);

