function resource_factors = find_resource_factors(outvec)

tt=size(outvec,1);
months=size(outvec,2);

for imonth=1:months
    vec=outvec(:,imonth);
    resource_factors.avail(imonth)=length(find(vec))/tt;
    resource_factors.capac(imonth)=(sum(vec)/max(vec))/tt;
end