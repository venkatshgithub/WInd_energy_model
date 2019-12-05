clc
clear

model='hummer'; %GE EWT or hummer

load('prices_kwh.mat') %prices_kwh
load('Estimated_Hourly_Demand_MW') %Hourly_Demand MW
load(strcat('final_power_output_',model)) %watts

%% Intermittency
jill_intermit_stuff;
plot_monthly_factors(resource_factors.monthly, demand_factors.monthly, model)


%% Money
jill_money_stuff;
