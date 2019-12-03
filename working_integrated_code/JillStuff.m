load('prices_kwh.mat') %prices_kwh
load('Estimated_Hourly_Demand') %Hourly_Demand
load('final_power_output') %watts

power_captured_kwh = 0.25*final_power_output*1e-3;
power_demand_kwh = Hourly_Demand;

[resource_factors, demand_met] = get_avail_cap_factors(...
    power_captured_kwh,power_demand_kwh);
plot_monthly_factors(resource_factors.monthly)

revenue_usd_year = demand_met.*prices_kwh;
revenue_usd_total = sum(revenue_usd_year);

