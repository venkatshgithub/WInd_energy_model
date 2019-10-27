%main_script
% integrating all the functions/modules to get the plots

%Wind_power_avail = Windpower_model(inputs);
%Solar_power_avail = SolarPower_model(inputs);
clear all
close all
Power_in = 10000; %10kW 

mass_in = linspace(20,20,40); %20kg/sec

Temp_in_CO2 = linspace(300,300,40); % temperature of the CO2 in the low pressure tanks in Kelvins
Pressure_in_CO2 = linspace(3500000,3500000,40); % pressure of the CO2 in the low pressure tanks in Pa
Temp_out_CO2 = linspace(433,433,40);

Pressure_required_CO2 = linspace(13000000,13000000,40); % pressure required of the CO2 to store in the high pressure tanks in Pa

Pressure_avail_CO2 = linspace(101325,101325,40);
Q_recovered = 0;

compressor_efficiency = 0.8;

mass_out = compressor_function(Power_in,Temp_in_CO2,Temp_out_CO2,Pressure_avail_CO2,Pressure_required_CO2,compressor_efficiency);

