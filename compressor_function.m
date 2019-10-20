function [mass_out,exergy_efficiency] = compressor_function(Power_in,Temp_in,Temp_out,P_in,P_out,mass_in,compressor_efficiency,Q_recovered)

%Inputs:
% Power_in, mass_in and Q_recovery as float
% Temp_in, Temp_out, P_in, P_out as vectors (all must be same length and
% should be correspondent to each other)

%Outputs:
%mass_out and exergy_efficiency are vectors as well with same length as Temp_in

% Power_in = Wind turbine power input (Watts)
% Temp_in = Temperature in of the CO2 in Kelvin
% Temp_out = Temeprature out of the CO2 in Kelvin
% P_in = Pressure input of the CO2 in Pa
% P_out = Pressure output of the CO2 in Pa
% Compressor_efficiency = efficiency of the compressor used (dimensionless <1)
% Q_recovered = energy recovery in the units of Watts

%References used:

% Exergy Analysis of Industrial Air Compression 
%(https://www.researchgate.net/publication/44209817_Exergy_Analysis_of_Industrial_Air_Compression?
%...cont...
%....enrichId=rgreq-ae4380060bf3922d38ce6a7e82d7d575-XXX&enrichSource=Y292ZXJQYWdlOzQ0MjA5ODE3O0FTOjExODgzMTc3OTQyMjIxM0AxNDA1MzQzMTEyNzQ2&el=1_x_2&_esc=publicationCoverPdf

enthalpy_out = zeros(length(Temp_in));
enthalpy_in = zeros(length(Temp_in));
entropy_out = zeros(length(Temp_in));
entropy_in = zeros(length(Temp_in));
mass_out = zeros(length(Temp_in));
exergy_efficiency = zeros(length(Temp_in));


for i=1:length(Temp_in)
    enthalpy_out(i) = py.CoolProp.CoolProp.PropsSI('H','T',Temp_in(i),'P',P_in(i),'R744');
    enthalpy_in(i) = py.CoolProp.CoolProp.PropsSI('H','T',Temp_out(i),'P',P_out(i),'R744');

    entropy_out(i) = py.CoolProp.CoolProp.PropsSI('S','T',Temp_in(i),'P',P_in(i),'R744');
    entropy_in(i) = py.CoolProp.CoolProp.PropsSI('S','T',Temp_out(i),'P',P_out(i),'R744');

    mass_out(i) = compressor_efficiency*Power_in/(enthalpy_out-enthalpy_in);
    
    X_destroyed = compressor_efficiency*Power_in+mass_in(i)*(enthalpy_in(i)-Temp_in(i)*entropy_in(i))-mass_out(i)*(enthalpy_out(i)-Temp_out(i)*entropy_out(i))...
                  -Q_recovered;     
        
    exergy_efficiency(i) = (Power_in-X_destroyed)/Power_in;

    mass_out(i) = (exergy_efficiency(i)*compressor_efficiency*Power_in)/(enthalpy_out(i)-enthalpy_in(i));
end


end

