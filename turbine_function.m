function [W_out,Temp_out] = turbine_function(Temp_in,P_in,P_out,mass_in,turbine_efficiency)

%Inputs:
% mass_in and turbine_efficieny as float
% Temp_in, P_in, P_out as vectors (all must be same length and
% should be correspondent to each other)

% Units
% Temp_in = Temperature in of the CO2 in Kelvin
% Temp_out = Temeprature out of the CO2 in Kelvin
% P_in = Pressure input of the CO2 in Pa
% P_out = Pressure output of the CO2 in Pa
% Turbine_efficiency = efficiency of the turbine used (dimensionless <1)
% mass_in = mass flow rate in kg/s
% W_out = power output in Watts



enthalpy_out_s  = zeros(length(Temp_in),1);
enthalpy_in     = zeros(length(Temp_in),1);
entropy_in      = zeros(length(Temp_in),1);
T_out_s         = zeros(length(Temp_in),1);
W_out_s         = zeros(length(Temp_in),1);
W_out           = zeros(length(Temp_in),1);
enthalpy_out    = zeros(length(Temp_in),1);
Temp_out        = zeros(length(Temp_in),1);

for i=1:length(Temp_in)
    % find isentropic values of outlet enthalpy and temperature using
    % property tables
    enthalpy_in(i)      = py.CoolProp.CoolProp.PropsSI('H','T',Temp_in(i),'P',P_in(i),'R744');
    entropy_in(i)       = py.CoolProp.CoolProp.PropsSI('S','T',Temp_in(i),'P',P_in(i),'R744');
    enthalpy_out_s(i)   = py.CoolProp.CoolProp.PropsSI('H','S',entropy_in(i),'P',P_out(i),'R744');
    T_out_s(i)          = py.CoolProp.CoolProp.PropsSI('T','S',entropy_in(i),'P',P_out(i),'R744');
    % find isentropic power output
    W_out_s(i)          = (enthalpy_in(i) - enthalpy_out_s(i))*mass_in;
    % Use efficiency to find real power, enthalpy, and temperature outputs
    W_out(i)            = turbine_efficiency*W_out_s(i);
    enthalpy_out(i)     = enthalpy_in(i)- W_out(i);
    Temp_out(i)            = py.CoolProp.CoolProp.PropsSI('T','H',enthalpy_out(i),'P',P_out(i),'R744');
end

end





