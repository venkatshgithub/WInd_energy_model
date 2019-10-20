function [mass_out,exergy_efficiency] = compressor_function(Power_in,Temp_in,Temp_out,P_in,P_out,mass_in,compressor_efficiency,Q_recovered)


% Power_in = Wind turbine power input (Watts)
% Temp_in = Temperature in of the CO2 in Kelvin
% Temp_out = Temeprature out of the CO2 in Kelvin
% P_in = Pressure input of the CO2 in Pa
% P_out = Pressure output of the CO2 in Pa
% Compressor_efficiency = efficiency of the compressor used (dimensionless <1)
% Q_recovered = energy recovery in the units of Watts

enthalpy_out = py.CoolProp.CoolProp.PropsSI('H','T',Temp_in,'P',P_in,'R744');
enthalpy_in = py.CoolProp.CoolProp.PropsSI('H','T',Temp_out,'P',P_out,'R744');

entropy_out = py.CoolProp.CoolProp.PropsSI('S','T',Temp_in,'P',P_in,'R744');
entropy_in = py.CoolProp.CoolProp.PropsSI('S','T',Temp_out,'P',P_out,'R744');

mass_out = compressor_efficiency*Power_in/(enthalpy_out-enthalpy_in);

X_destroyed = compressor_efficiency*Power_in+mass_in*(enthalpy_in-Temp_in*entropy_in)-mass_out*(enthalpy_out-Temp_out*entropy_out)...
                  -Q_recovered;
              
        
exergy_efficiency = (Power_in-X_destroyed)/Power_in;

mass_out = (exergy_efficiency*compressor_efficiency*Power_in)/(enthalpy_out-enthalpy_in);

end

