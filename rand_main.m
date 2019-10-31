%main_script
% integrating all the functions/modules to get the plots

%Wind_power_avail = Windpower_model(inputs);
%Solar_power_avail = SolarPower_model(inputs);
clear all
close all
Power_in = linspace(1000,1000000,15); %10kW 
%Power_in  = 1000;
Temp_in_CO2 = 300;% temperature of the CO2 in the low pressure tanks in Kelvins
Pressure_in_CO2 = 101325; % pressure of the CO2 in the low pressure tanks in Pa

Pressure_required_CO2 = linspace(10E06,20E06,5); % pressure required of the CO2 to store in the high pressure tanks in Pa

compressor_efficiency = 0.8;

mass_out = zeros(length(Pressure_required_CO2),length(Power_in));
Temp_out = zeros(length(Pressure_required_CO2),length(Power_in));

for press_out=1:length(Pressure_required_CO2)
        [mass_out(press_out,:),Temp_out(press_out,:)] = compressor_function(Power_in,Temp_in_CO2,Pressure_in_CO2,Pressure_required_CO2(press_out),compressor_efficiency);
end

h = figure;
for i  = 1:5
    plot(Power_in*1E-03,mass_out(i,:),'Linewidth',2);
    hold on;
end
set(gca,'Fontsize',28);
xlim([1,1000]);
ylim([min(min(mass_out)),max(max(mass_out))])
xlabel('Wind Power in kW','Fontsize',28);
ylabel('Mass flow rate of compressed CO2 in kg/sec','Fontsize',28);
legend('1 MPa','1.25 MPa','1.5 MPa','1.75 MPa','2.0 MPa','Fontsize',28);

