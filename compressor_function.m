function [mass_out,Temp_out] = compressor_function(Power_in,Temp_in,P_in,P_out,compressor_efficiency)

%Inputs:
% Power_in and Q_recovery as float in Watts
% Temp_in, Temp_out, P_in, P_out as vectors (all must be same length and
% should be correspondent to each other)
% T_amb is ambient temperature in K

%Outputs:
%mass_out and exergy_efficiency are vectors as well with same length as Temp_in

% Power_in = Wind turbine power input (Watts)
% Temp_in = Temperature in of the CO2 in Kelvin
% Temp_out = Temeprature out of the CO2 in Kelvin
% P_in = Pressure input of the CO2 in Pa
% P_out = Pressure output of the CO2 in Pa
% Compressor_efficiency = efficiency of the compressor used (dimensionless <1)
% Q_recovered = energy recovery in the units of Watts

enthalpy_out = zeros(length(Power_in));
enthalpy_in = zeros(length(Power_in));
entropy_in = zeros(length(Power_in));
T_out = zeros(length(Power_in));
M_out = zeros(length(Power_in));


for i=1:length(Power_in)
    enthalpy_in(i) = py.CoolProp.CoolProp.PropsSI('H','T',Temp_in,'P',P_in,'R744');
    entropy_in(i) = py.CoolProp.CoolProp.PropsSI('S','T',Temp_in,'P',P_in,'R744');
      
    enthalpy_out(i) = py.CoolProp.CoolProp.PropsSI('H','S',entropy_in(i),'P',P_out,'R744');
    T_out(i) =  py.CoolProp.CoolProp.PropsSI('T','S',entropy_in(i),'P',P_out,'R744');
    %isentropic compression
    M_out(i) = (compressor_efficiency*Power_in(i))/(enthalpy_out(i)-enthalpy_in(i));  
end
    mass_out = M_out(:,1);
    Temp_out = T_out(:,1);
end

