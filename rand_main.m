%main_script
% integrating all the functions/modules to get the plots

%Wind_power_avail = Windpower_model(inputs);
%Solar_power_avail = SolarPower_model(inputs);
clear all
close all
Power_in = Wind_power(80,77,0.3); % GE 1.5 MW wind turbine of CP 0.3, dia 77m at height 80m
Temp_in_CO2 = 300;% temperature of the CO2 in the low pressure tanks in Kelvins
Pressure_in_CO2 = 101325; % pressure of the CO2 in the low pressure tanks in Pa

Pressure_required_CO2 = linspace(20E06,20E06,3); % pressure required of the CO2 to store in the high pressure tanks in Pa

compressor_efficiency = 0.8;
turbine_efficiency = 0.87;

mass_out = zeros(length(Pressure_required_CO2),length(Power_in));
Temp_out = zeros(length(Pressure_required_CO2),length(Power_in));

for press_out=1:length(Pressure_required_CO2)
        [mass_out(press_out,:),Temp_out(press_out,:)] = compressor_function(Power_in,Temp_in_CO2,Pressure_in_CO2,Pressure_required_CO2(press_out),compressor_efficiency);
end

final_Temp_out = zeros(length(Pressure_required_CO2),length(Power_in));
work_out = zeros(length(Pressure_required_CO2),length(Power_in));
press_out_turb = [0.1E06,1E06,8E06];
%4turbine_function(Temp_in,P_in,P_out,mass_in,turbine_efficiency)

for press_out=1:length(Pressure_required_CO2)
    [work_out(press_out,:),final_Temp_out(press_out,:)] = turbine_function(Temp_out(press_out,:),Pressure_required_CO2(press_out),press_out_turb(press_out),mass_out(press_out,:),turbine_efficiency);
end

efficiency_final = zeros(length(Pressure_required_CO2),length(Power_in));

for press_out = 1:length(Pressure_required_CO2)
    efficiency_final(press_out,:) = work_out(press_out,:)/Power_in;
end

h = figure;
for i  = 1:length(Pressure_required_CO2)
    plot(Power_in*1E-03,mass_out(i,:),'Linewidth',2);
    hold on;
end
set(gca,'Fontsize',28);
%xlim([1,1000]);
ylim([min(min(mass_out)),max(max(mass_out))])
xlabel('Wind Power in kW','Fontsize',28);
ylabel('Mass flow rate of compressed CO2 in kg/s','Fontsize',28);
legend('0.1 MPa','1 MPa','8 MPa','Fontsize',28);


h = figure;
for i  = 1:length(Pressure_required_CO2)
    plot(mass_out(i,:),Temp_out(i,:),'Linewidth',2);
    hold on;
end
set(gca,'Fontsize',28);
%xlim([1,1000]);
%ylim([min(min(mass_out)),max(max(mass_out))])
xlabel('Mass flow rate of compressed CO2 in kg/s','Fontsize',28);
ylabel('Temperature of CO2 from compressor at 12 MPa','Fontsize',28);
legend('0.1 MPa','1 MPa','8 MPa','Fontsize',28);

h = figure;
for i  = 1:length(Pressure_required_CO2)
    plot(mass_out(i,:),final_Temp_out(i,:),'Linewidth',2);
    hold on;
end
set(gca,'Fontsize',28);
%xlim([1,1000]);
%ylim([min(min(mass_out)),max(max(mass_out))])
xlabel('Mass flow rate of compressed CO2 in kg/s','Fontsize',28);
ylabel('Final temperature of CO2 from compressor at 0.1 MPa','Fontsize',28);
legend('0.1 MPa','1 MPa','8 MPa','Fontsize',28);

h = figure;
for i = 1:length(Pressure_required_CO2)
    plot(Power_in*1E-03,efficiency_final(i,:),'Linewidth',2);
    hold on;
end
set(gca,'Fontsize',28);
%xlim([1,1000]);
%ylim([min(min(mass_out)),max(max(mass_out))])
xlabel('Wind Power in kW','Fontsize',28);
ylabel('Final efficiency','Fontsize',28);
legend('0.1 MPa','1 MPa','8 MPa','Fontsize',28);
