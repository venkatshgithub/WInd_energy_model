clc
clear

%Remove the title line from the excel before trying to run this code

year=2017;

fixNans_cell = @(x) x(cellfun('isclass', x, 'char'));
fixNans_vector = @(x) x(~isnan(x));
make_fnames = @(x) {[num2str(year), '_A_ERCOT-HourlyRealTime.csv'], [num2str(year), '_B_ERCOT-HourlyRealTime.csv']};
make_structname = @(x) ['yr',num2str(year)];

fnames = make_fnames(year);
sname = make_structname(year);

prices_short = [];
datenums = []; %note that juliandate is a MATLABr reserved function name

for i=1:length(fnames)
fname=fullfile(pwd,fnames{i});

[~,~,dateString_long]=xlsread(fname,'A:A');
[~,~,startTimes_long]=(xlsread(fname,'B:B'));
[~,~,endTimes_long]=(xlsread(fname,'C:C'));
[~,~,prices_long]=(xlsread(fname,'D:D'));

dateString_short = fixNans_cell(dateString_long);
startTimes_short = fixNans_vector(cell2mat(startTimes_long));
endTimes_short = fixNans_vector(cell2mat(endTimes_long));
prices_short_new = fixNans_vector(cell2mat(prices_long));

dates = datetime(dateString_short);
[years,months,days] = ymd(dates);

hours = floor(startTimes_short*24);
minutes = rem(startTimes_short*24,1)*60;
seconds = zeros(size(hours));

datenums_new = datenum(years, months, days, hours, minutes, seconds);

prices_short = [prices_short; prices_short_new];
datenums = [datenums; datenums_new];

end

sorted_matrix = sortrows([datenums, prices_short]);
datenums_sorted = sorted_matrix(:,1);
prices_sorted = sorted_matrix(:,2);

%reshape for averaging
prices_hourly_sorted = mean(reshape(prices_sorted,4,[]))';
datenums_hourly_sorted = datenums_sorted(1:4:end,:);

prices_kwh.(sname).datenums = datenums_hourly_sorted;
prices_kwh.(sname).datestrs = datestr(datenums_hourly_sorted);
prices_kwh.(sname).prices = prices_hourly_sorted;


save(fullfile(pwd,'prices_kwh.mat'),'prices_kwh')