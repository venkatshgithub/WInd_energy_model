function [power_solar] = Solar_power(area)
tout = struct2array(load('tout_loredo.mat'));
lat = 27.57;
long = -99.49;
lsi = 105;
inlettemp = 24;
power_solar = Solar(lat,long,lsi,inlettemp,area,tout);
disp(power_solar)
end

