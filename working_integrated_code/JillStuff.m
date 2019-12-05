clc
clear

load('prices_kwh.mat') %prices_kwh
load('Estimated_Hourly_Demand_MW') %Hourly_Demand MW
load('final_power_output') %watts

%% Intermittency
jill_intermit_stuff;
% plot_monthly_factors(resource_factors.monthly, demand_factors.monthly)


%% Money

jill_money_stuff