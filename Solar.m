function [Qi] = Solar(lat,long,lsi,inlettemp,tout)
% A area of solar thermal
% dn[] is day numbervector from 0 to 364
% time[] 0 to 23 vector
%lat, long, lsi=local standard input
% orien = surface orientation (0 for south) inclin =angle of inclination of the thermal plate
% time equation = timeeq[i]=9.87*SIN(4*PI()*(dn[i]-81)/364)-7.53*COS(2*PI()*(dn[i]-81)/364)-1.5*SIN(2*PI()*(dn[i]-81)/364)
%apt is apparent solar time ast[j]=time[j]+timeeq[j]/60+(lsi-long)/15
%solar declination sd[i]=23.45*SIN((360*(284+dn[i])/365)*PI()/180)
% hour angle hra[i]=15*(ast[i]-12)
dn=[1:365];
time=[1:24];
orien=0;
inclin=90;
timeeq=9.87*SIN(4*PI()*(dn-81)/364)-7.53*COS(2*PI()*(dn-81)/364)-1.5*SIN(2*PI()*(dn-81)/364);
ast=time+timeeq/60+(lsi-long)/15;
sd=23.45*SIN((360*(284+dn)/365)*PI()/180);
hra=15*(ast-12);
if  ASIN(COS(lat*PI()/180)*COS(sd*PI()/180)*COS(hra*PI()/180)+SIN(lat*PI()/180)*SIN(sd*PI()/180))*180/PI()>1
    solal=ASIN(COS(lat*PI()/180)*COS(sd*PI()/180)*COS(hra*PI()/180)+SIN(lat*PI()/180)*SIN(sd*PI()/180))*180/PI();
else
   solal=0;
end
%the solar azimuth angle = solazimuth
solazimuth=ACOS((SIN(solal*PI()/180)*SIN(lat*PI()/180)-SIN(sd*PI()/180))/(COS(solal*PI()/180)*COS(lat*PI()/180)))*K2/ABS(hra)*180/PI();
%aoi = angle of incidence and  caoi=corrected angle of incidence 
%caoir= corrected angle of incidence in radians
aoi=COS(solal*PI()/180)*COS((solazimuth*PI()/180)-(orien*PI()/180))*SIN(inclin*PI()/180)+SIN(solal*PI()/180)*COS((inclin*PI()/180));
if solal>1
caoi=ACOS((aoi+ABS(aoi))/2)*180/PI();
else
    caoi=90;
end
caoir=0.01745329*caoi;
for dn=1:365
 if dn<=31 
    A= 1202;% A(W/m2) and B and C are atmospheric attenuation constants
    B=0.141;
    C=0.103;
 elseif dn>31&&dn<=59
        A=1187;
        B=0.142;
        C=0.104;
 elseif dn>59&&dn<=90
       A=1164;
       B= 1130;
       C=0.12;
 elseif dn>90&&dn<=120
       A=1130;
       B= 0.164;
       C=0.12;
 elseif dn>120&&dn<=151
       A=1106;
       B= 0.177;
       C=0.13;
 elseif dn>151&&dn<=181
           A=1092;
           B=0.185;
           C=0.137;
 elseif dn>181&&dn<=212
           A=1093;
           B= 0.186;
           C=0.138;
 elseif dn>212&&dn<=243
           A=1107;
           B= 0.182;
           C=0.134;
 elseif dn>243&&dn<273
           A=1136;
           B= 0.165;
           C=0.121;
 elseif dn>273&&dn<=303
            A=1166;
            B= 0.152;
            C=0.111;
 elseif dn>212&&dn<=334
            A=1190;
            B= 0.142;
            C=0.106;
 elseif dn>334&&dn<=365
         A=1204;
         B= 0.141;
         C=0.103;
    else
       error(msg);
 end
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
  diffuse=C*gnd*(0.55+0.437*cos(caoir)+0.313*(cos(caoir)^2));
  ground=gdn*0.5*0.5*(sin(solal*0.01745329)+C);
  G=direct+diffuse+ground;
  % taking initial values for internal surface temperature and external
  % surface temperature tis and tes respectively
  tis=20;
  tes=60;
  %tsky is the sky temperature
  tsky=(tout-6)*0.707+tout*(1-0.707);
  % h is the convective coefficient which is taken for exterior surface,
  % ground,glass and sky tes is calculated
  for i=1:100
     hcext=sqrt(((0.84*(tout+273)-(tes+273))^(1/3))^2+(2.38*5.4^0.89)^2);     
     hrg=0.9*5.67*10^-8*0.5*((273+tout)^4-(273+tes)^4)/((273+tout)-(273+tes));
     hrsky=0.9*5.67*10^-8*0.5*((tsky)^4-(tes)^4)/((tsky)-(tes));
     hrglass=5.67*10^-8*0.81*((273+tes)^4-(273+inlettemp)^4)/((273+tes)-(273+inlettemp));%0.81 is absorptance which can be changed
     tes=((2+hrglass)*tis+0.14+G+hcext*tout+hrg*tout+hrsky*tsky)/(2+hrglass+hcext+hrg+hrsky);
     
  end   
  % to calclulate surface interirior temperature
  for i=1:100
     hcin=1.31*(abs(tis-inlettemp));    
     %assuming a single surface and no radiative heat transfer inside the
     %solar panels
     tis=((2+hrglass)*tes+hcin*inlettemp)/(2+hrglass+hcin);
     
  end 
Qi=hc*area*(tis-inlettemp);

end

