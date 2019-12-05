function [resource_factors, demand_met] = get_avail_cap_factors(captured_year,demand_year)
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

% monthly stuff
mm=tt/12;
captured_month=reshape(captured_year,[mm,12]);
available_month = reshape(available_year,[mm,12]);

resource_factors.monthly.intermit = find_resource_factors(captured_month);
resource_factors.monthly.storage = find_resource_factors(available_month);

