function demand_met_factor = find_demand_met_factor(demand_met, demand)
tt=length(demand_met);
months=size(demand_met,2);

demand_met_capped = demand_met;
demand_met_capped(demand_met_capped>demand) = ...
    demand(demand_met_capped>demand);

for imonth=1:months
    demand_month = demand(:,imonth);
    demand_met_month = demand_met(:,imonth);
    demand_met_capped_month = demand_met_capped(:,imonth);
    
    demand_met_factor.avail(imonth) = length(find(demand_met_month>=demand_month))/tt;
    demand_met_factor.capac(imonth) = mean(demand_met_capped_month./demand_month);
end