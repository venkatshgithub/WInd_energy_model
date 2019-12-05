% Call this script as a part of JillStuff, just put in another function to
% declutter

%% Natural resources
wind_year = Wind_power_jill(75,0.3, model)*1e-3;

solar_area = 10;
solar_year = Solar_power(1.0);
solar_year = abs(solar_year)*solar_area*1e-3;

%% Our cycle
meet_factor.GE=(1/4)*0.25/100;
meet_factor.EWT=(0.5)*(1/4)*0.25/100;
meet_factor.hummer=(0.05)*(1/4)*0.25/100;

power_captured_kwh = final_power_output*1e-3;
power_captured_kwh(power_captured_kwh>4e3)=2e3;
power_demand_kwh = meet_factor.(model)*Hourly_Demand*1e3;
power_prices_kwh=prices_kwh.yr2017.prices/100;

[resource_factors, demand_factors] = get_avail_cap_factors(...
    power_captured_kwh,power_demand_kwh, solar_year, wind_year);

