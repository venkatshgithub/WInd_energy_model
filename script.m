tout = struct2array(load('tout.mat'));
lat = 31.76;
long = 106.48;
lsi = 105;
inlettemp = 24;
area = 1.0;
hrs = transpose(linspace(1,365*24,365*24));
sumhrs=transpose(linspace(1,6625,6625));


Q = Solar(lat,long,lsi,inlettemp,area,tout);

Average_Year = mean(reshape(Q,[24 365]));
Average_Day =  Q(5088:5112);
Summer= Q(1392:8016);

figure;
%plot(hrs,Q,'Linewidth',2);
plot(Average_Year);
set(gca,'Fontsize',20);
xlabel('hours');
ylabel('Q');
figure
%X = linspace(1,365,365);
%fit_average_year = fit(X(:),Average_Year(:),'cubicinterp');

%plot(fit_average_year);
figure
plot(Average_Day);
figure;
plot(sumhrs,Summer,'Linewidth',2);
% for supercritica Co2 31.25C