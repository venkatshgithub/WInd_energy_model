function [Qi] = Solar(lat,long,lsi,inlettemp,area,tout)
% A area of solar thermal
% dn[] is day numbervector from 0 to 364
% time[] 0 to 23 vector
%lat, long, lsi=local standard input
% orien = surface orientation (0 for south) inclin =angle of inclination of the thermal plate
% time equation = timeeq[i]=9.87*sin(4*pi*(dn[i]-81)/364)-7.53*cos(2*pi*(dn[i]-81)/364)-1.5*sin(2*pi*(dn[i]-81)/364)
%apt is apparent solar time ast[j]=time[j]+timeeq[j]/60+(lsi-long)/15
%solar declination sd[i]=23.45*sin((360*(284+dn[i])/365)*pi/180)
% hour angle hra[i]=15*(ast[i]-12)
dn=(1:365);
time=(1:24);
timeeq = zeros(length(dn)*length(time),1);
Qi = zeros(length(dn)*length(time),1);
orien=0;
inclin=90;

counter = 1;
for dnum = 1:length(dn)
    timeeq(dnum)=9.87*sin(4*pi*(dn(dnum)-81)/364)-7.53*cos(2*pi*(dn(dnum)-81)/364)-1.5*sin(2*pi*(dn(dnum)-81)/364);
    for tim = 1:length(time)
        ast=time(tim)+timeeq(dnum)/60+(lsi-long)/15;
        sd=23.45*sin((360*(284+dn(dnum))/365)*pi/180);
        hra=15*(ast-12);
        if  asin(cos(lat*pi/180)*cos(sd*pi/180)*cos(hra*pi/180)+sin(lat*pi/180)*sin(sd*pi/180))*180/pi>1
            solal=asin(cos(lat*pi/180)*cos(sd*pi/180)*cos(hra*pi/180)+sin(lat*pi/180)*sin(sd*pi/180))*180/pi;
        else
            solal=0;
        end
        %the solar azimuth angle = solazimuth
        solazimuth=acos((sin(solal*pi/180)*sin(lat*pi/180)-sin(sd*pi/180))/(cos(solal*pi/180)*cos(lat*pi/180)))*hra/abs(hra)*180/pi;
        %aoi = angle of incidence and  caoi=corrected angle of incidence 
        %caoir= corrected angle of incidence in radians
        aoi=cos(solal*pi/180)*cos((solazimuth*pi/180)-(orien*pi/180))*sin(inclin*pi/180)+sin(solal*pi/180)*cos((inclin*pi/180));    
        if solal>1
            caoi=acos((aoi+abs(aoi))/2)*180/pi;
        else
            caoi=90;
        end
        caoir=(pi/180)*caoi;
        
        if dn(dnum)<=31 
            A= 1202;% A(W/m2) and B and C are atmospheric attenuation constants
            B=0.141;
            C=0.103;
        elseif dn(dnum)>31  &&  dn(dnum)<=59
            A=1187;
            B=0.142;
            C=0.104;
        elseif dn(dnum)>59 && dn(dnum)<=90
             A=1164;
             B= 0.15;
             C=0.12;
        elseif dn(dnum)>90&&dn(dnum)<=120
             A=1130;
             B= 0.164;
             C=0.12;
        elseif dn(dnum)>120&&dn(dnum)<=151
             A=1106;
             B= 0.177;
             C=0.13;
        elseif dn(dnum)>151&&dn(dnum)<=181
             A=1092;
             B=0.185;
             C=0.137;
        elseif dn(dnum)>181&&dn(dnum)<=212
             A=1093;
             B= 0.186;
             C=0.138;
        elseif dn(dnum)>212&&dn(dnum)<=243
             A=1107;
             B= 0.182;
             C=0.134;
        elseif dn(dnum)>243&&dn(dnum)<273
             A=1136;
             B= 0.165;
             C=0.121;
        elseif dn(dnum)>273&&dn(dnum)<=303
             A=1166;
             B= 0.152;
             C=0.111;
        elseif dn(dnum)>212&&dn(dnum)<=334
             A=1190;
             B= 0.142;
             C=0.106;
        elseif dn(dnum)>334&&dn(dnum)<=365
             A=1204;
             B= 0.141;
             C=0.103;
        else
            error("Could not find day allocation");
        end
        %atmospheric clearness Cn is taken from ashrae handbook for texas
        Cn=0.9;
        % gdn is normal radiation
        if solal==0
            gdn=0;
        else
            gdn=A*Cn/exp(B/sin(solal));
        end
        %next the direct diffuse and ground radiations are calculated and G
        %amounts to the sum of all
        direct=gdn*cos(caoir);
        diffuse=C*gdn*(0.55+0.437*cos(caoir)+0.313*(cos(caoir)^2));
        ground=gdn*0.5*0.5*(sin(solal*0.01745329)+C);
        G=direct+diffuse+ground;
        % taking initial values for internal surface temperature and external
        % surface temperature tis and tes respectively
        tis_prev=80;
        tes_prev=100;
        %tsky is the sky temperature
        tsky=(tout(counter)-6)*0.707+tout(counter)*(1-0.707);
  % h is the convective coefficient which is taken for exterior surface,
  % ground,glass and sky tes is calculated
        err_itr = 100;
        abs_fac = 0.93;
        while err_itr >1E-03
            disp('I am in tes iteration');
            hcext=sqrt(((0.84*(tes_prev+273)-(tout(counter)+273))^(1/3))^2+(2.38*5.4^0.89)^2);     
            hrg=0.9*5.67*10^-8*0.5*((273+tout(counter))^4-(273+tes_prev)^4)/((273+tout(counter))-(273+tes_prev));
            hrsky=0.9*5.67*10^-8*0.5*((tsky)^4-(tes_prev)^4)/((tsky)-(tes_prev));
            hrglass=5.67*10^-8*abs_fac*((273+tes_prev)^4-(273+inlettemp)^4)/((273+tes_prev)-(273+inlettemp));%0.81 is absorptance which can be changed
            tes_curr=((2+hrglass)*tis_prev+0.14+G+hcext*tout(counter)+hrg*tout(counter)+hrsky*tsky)/(2+hrglass+hcext+hrg+hrsky);
            tes_prev = tes_curr;
            err_itr = abs(tes_curr-tes_prev);
        end   
        tes=tes_curr;
        err_itr = 100;
  % to calclulate surface interirior temperature
        while err_itr >1E-03
            disp('I am in tis iteration');
            hrglass=5.67*10^-8*abs_fac*((273+tes)^4-(273+inlettemp)^4)/((273+tes)-(273+inlettemp));%0.81 is absorptance which can be changed
            hcin=1.31*(abs(tis_prev-inlettemp));    
            %assuming a single surface and no radiative heat transfer inside the
            %solar panels
            tis_curr=((2+hrglass)*tes+hcin*inlettemp)/(2+hrglass+hcin);
            tis_prev = tis_curr;
            err_itr = abs(tis_curr-tis_prev);
        end 
        Qi(counter)=hcin*area*(tis_curr-inlettemp);
        if(Qi(counter)<0 || Qi(counter)>500)
            Qi(counter) = 0.0;
        end
        counter = counter+1;
    end
end
disp('counter ');
disp(counter);

end

