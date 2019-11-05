tout = struct2array(load('tout.mat'));
lat = 31.76;
long = 106.48;
lsi = 105;
inlettemp = 24;
area = 1.0;
hrs = transpose(linspace(1,365*24,365*24));

Q = Solar(lat,long,lsi,inlettemp,area,tout);

Avg_Q = reshape(Q,[24,365]);


figure;
plot(hrs,Q,'Linewidth',2);
set(gca,'Fontsize',20);
xlabel('hours');
ylabel('Q');