function [resource_factors, demand_factors] = get_avail_cap_factors(captured_year,demand_year, solar_year, wind_year)
%captured - vector containing the energy captured throughout a year
%demand - how much power are we trying to deliver
% these two should be the same length
% available=stored+captured

% annual stuff
tt=length(captured_year);
captured_year=reshape(captured_year,[tt,1]);
demand_year=reshape(demand_year,[tt,1]);

[available_year,demand_met] = get_available_vec(captured_year,demand_year);

resource_factors.annual.intermit = find_resource_factors(captured_year);
resource_factors.annual.storage = find_resource_factors(available_year);
resource_factors.annual.solar = find_resource_factors(solar_year);
resource_factors.annual.wind = find_resource_factors(wind_year);

demand_factors.annual.intermit = find_demand_met_factor(captured_year, demand_year);
demand_factors.annual.storage = find_demand_met_factor(demand_met, demand_year);
demand_factors.annual.solar = find_demand_met_factor(solar_year, demand_year);
demand_factors.annual.wind = find_demand_met_factor(wind_year, demand_year);
demand_factors.demand_met_kwh = demand_met;

% monthly stuff
mm=tt/12;
captured_month=reshape(captured_year,[mm,12]);
available_month = reshape(available_year,[mm,12]);
demand_month = reshape(demand_year, [mm,12]);
demand_met_month = reshape(demand_met, [mm,12]);
solar_month = reshape(solar_year,[mm,12]);
wind_month=reshape(wind_year,[mm,12]);

resource_factors.monthly.intermit = find_resource_factors(captured_month);
resource_factors.monthly.storage = find_resource_factors(available_month);
resource_factors.monthly.solar = find_resource_factors(solar_month);
resource_factors.monthly.wind = find_resource_factors(wind_month);

demand_factors.monthly.intermit = find_demand_met_factor(captured_month, demand_month);
demand_factors.monthly.storage = find_demand_met_factor(demand_met_month, demand_month);
demand_factors.monthly.solar = find_demand_met_factor(solar_month, demand_month);
demand_factors.monthly.wind = find_demand_met_factor(wind_month, demand_month);

