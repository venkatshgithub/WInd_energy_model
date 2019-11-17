function [Turb_in_temp] = Heat_addition(pump_out_temp,pump_press_out,mass_out,power_solar,heater_efficiency)

enthalpy_in = zeros(length(power_solar),1);
enthalpy_out = zeros(length(power_solar),1);
Turb_in_temp =  zeros(length(power_solar),1);
for i = 1:length(power_solar)
    enthalpy_in(i) = py.CoolProp.CoolProp.PropsSI('H','T',pump_out_temp,'P',pump_press_out,'R744');
    if mass_out(i)==0
        enthalpy_out(i) = enthalpy_in(i);
    else
        enthalpy_out(i) = enthalpy_in(i)+heater_efficiency*power_solar(i)/mass_out(i);
    end
    Turb_in_temp = py.CoolProp.CoolProp.PropsSI('T','H',enthalpy_out(i),'P',pump_press_out,'R744');
end

