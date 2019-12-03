function [available_vec, demand_met] = get_available_vec(captured_vec,demand_vec)

stored_energy=0;
tt=numel(captured_vec);
demand_met=zeros(size(captured_vec));
available_vec=zeros(size(captured_vec));

for i=1:tt
    new_energy=captured_vec(i);
    stored_energy=new_energy+stored_energy;
    available_vec(i) = stored_energy;
    
    current_demand=demand_vec(i);
    if stored_energy >= current_demand
        demand_met(i) = current_demand;
        stored_energy = stored_energy-current_demand;
    else
        demand_met(i) = stored_energy;
        stored_energy=0;
    end 
end