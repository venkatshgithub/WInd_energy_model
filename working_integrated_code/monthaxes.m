function monthaxes(fsize, veclength) 

set(gca,'xtick',linspace(1,veclength,12),'xticklabel',...
     {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
     'FontSize', fsize) ;
 
end