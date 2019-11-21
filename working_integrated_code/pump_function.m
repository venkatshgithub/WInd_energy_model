function [mass_out] = pump_function(Power_in,pump_in_temp,pump_pressure_in,pump_pressure_out,efficiency)

%considered isentropic compression and heat generated is removed

enthalpy_in = py.CoolProp.CoolProp.PropsSI('H','T',round(pump_in_temp,6),'P',round(pump_pressure_in,6),'R744');
entropy_in = py.CoolProp.CoolProp.PropsSI('S','T',round(pump_in_temp,6),'P',round(pump_pressure_in,6),'R744');
entropy_out = entropy_in;
enthalpy_out = py.CoolProp.CoolProp.PropsSI('H','S',entropy_out,'P',pump_pressure_out,'R744');
mass_out = zeros(length(Power_in),1);
for i = 1:length(Power_in)
    mass_out(i) = (efficiency*Power_in(i))/(enthalpy_out-enthalpy_in);
end

end

