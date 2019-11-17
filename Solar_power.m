function [power_solar] = Solar_power(area)
tout = struct2array(load('tout.mat'));
lat = 31.76;
long = 106.48;
lsi = 105;
inlettemp = 24;
power_solar = Solar(lat,long,lsi,inlettemp,area,tout);
end

