%main_script
% integrating all the functions/modules to get the plots
clear all
close all

%% Inputs
Turbine_pressure_in = 20E06; %MPa
pump_pressure_out = Turbine_pressure_in;
Turbine_pressure_out = 0.52E06;%MPa
pump_pressure_in = Turbine_pressure_out;
pump_efficiency = 0.8;
turbine_efficiency = 0.87;
heater_efficiency = 0.95;
area = 10; %1m2 of solar thermal plant

%% Other calculations

% pump input temperature is basically saturated liquid temperature at turbine out
% pressure
pump_in_temp = py.CoolProp.CoolProp.PropsSI('T','Q',0,'P',pump_pressure_in,'R744');

%As per the Saravi 2019 ("An invesi. into sCO2 pump
%performance...."), there is a raise of 10K due to compression. Hence, the
%pump output temperature is taken as input+10K
pump_out_temp = pump_in_temp+10;

%% Acquiring wind power available

Power_in = Wind_power(80,77,0.3); % GE 1.5 MW wind turbine of CP 0.3, dia 77m at height 80m

%% Calling pump function to find the mass rate of CO2 for the available wind power 
    % Note: The actual process of compression is not known. So, as per the real scenario in Steam Rankine cycle, we
    % considered liquid compression rather gas compression. 
mass_out = pump_function(Power_in,pump_in_temp,pump_pressure_in,pump_pressure_out,pump_efficiency);

%% Calling solar function to find the solar power available in that region over a year
power_solar = Solar_power(1.0);

power_solar = abs(power_solar)*area;

%% Calling heat addition to raise the temperature and reaching supercritical state of CO2

Turb_in_temperature = Heat_addition(pump_out_temp,pump_pressure_out,mass_out,power_solar,heater_efficiency);

final_power_output = zeros(length(mass_out),1);
Turbine_out_temp = zeros(length(mass_out),1);

%% Calling turbine function to find the final power output
for i = 1:length(mass_out)
    [final_power_output(i),Turbine_out_temp(i)] = turbine_function(Turb_in_temperature(i),Turbine_pressure_in,Turbine_pressure_out,mass_out(i),turbine_efficiency);
end

Total_efficiency = final_power_output./(power_solar+Power_in);

h = figure;
plot(linspace(1,365*24,365*24),Total_efficiency*100,'Linewidth',2);
set(gca,'Fontsize',28);
xlim([1,1000]);
ylim([min(min(mass_out)),100])
xlabel('Over a year','Fontsize',28);
ylabel('Final efficiency','Fontsize',28);
