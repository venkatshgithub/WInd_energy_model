clear all
close all

if exist('urms.mat','file')~=2
    disp('urms mat file does not exists creating one');
    urms = dlmread('urms.dat');
    save('urms.mat','urms');
else
    disp('urms mat file exists and loaded');
    load('urms.mat','urms');
end    

if exist('vrms.mat','file')~=2
    disp('vrms mat file does not exists creating one');
    vrms = dlmread('vrms.dat');
    save('vrms.mat','vrms');
else
    disp('vrms mat file exists and loaded');
    load('vrms.mat','vrms');
end    

if exist('trms.mat','file')~=2
    disp('Temperature_rms mat file doesn''t exists creating one');
    trms = dlmread('trms.dat');
    save('trms.mat','trms');
else
    disp('Temperature rms file exists and loaded');
    load('trms.mat','trms');
end

if exist('xcoord.mat','file')~=2
    disp('xcoord file does not exists creating one');
    x = dlmread('xcoord.dat');
    save('xcoord.mat','x');
else
    disp('xcoord file exists and loaded');
    load('xcoord.mat','x');
end

if exist('ycoord.mat','file')~=2
    disp('ycoord file does not exists creating one');
    y = dlmread('ycoord.dat');
    save('ycoord.mat','y');
else
    disp('ycoord file exists and loaded');
    load('ycoord.mat','y');
end

if exist('zcoord.mat','file')~=2
    disp('zcoord file does not exists creating one');
    z = dlmread('zcoord.dat');
    save('zcoord.mat','z');
else
    disp('zcoord file exists and loaded');
    load('zcoord.mat','z');
end
y = y+1.0;
utau=0.03731;
re=10400;
t_tau = 0.044008;
xplus = x*utau*re;
yplus = y*utau*re;
zplus = z*utau*re;

[X,Y] = meshgrid(xplus(1:405),yplus(1:98));
[Z,Y_] = meshgrid(zplus,yplus(1:98));

urms = urms./utau;
vrms = vrms./utau;
trms = trms./t_tau;

ut = urms.*trms;
vt = vrms.*trms;
uv = urms.*vrms;

ut_3D = permute(reshape(ut,193,193,1153),[1 3 2]);
vt_3D = permute(reshape(vt,193,193,1153),[1 3 2]);
uv_3D = permute(reshape(uv,193,193,1153),[1 3 2]);

xl=[xplus(132) xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)];
yl=[0 yplus(98)];

% x1=[xl(1) xl(1)];
x2=[xl(2) xl(2)];
x3=[xl(3) xl(3)];
x4=[xl(4) xl(4)];
x5=[xl(5) xl(5)];
x6=[xl(6) xl(6)];
x7=[xl(7) xl(7)];

ut_bwn = squeeze(ut_3D(79,1:405,:));
ut_alo = squeeze(ut_3D(96,1:405,:));
vt_bwn = squeeze(vt_3D(79,1:405,:));
vt_alo = squeeze(vt_3D(96,1:405,:));
uv_alo = squeeze(uv_3D(96,1:405,:));
uv_bwn = squeeze(uv_3D(79,1:405,:));

ut_up = squeeze(ut_3D(:,104,:));
ut_1d = squeeze(ut_3D(:,158,:));
ut_3d = squeeze(ut_3D(:,184,:));
ut_5d = squeeze(ut_3D(:,210,:));
ut_10d = squeeze(ut_3D(:,275,:));
ut_20d = squeeze(ut_3D(:,405,:));
ut_alo_max = squeeze(ut_3D(:,164,:));
ut_bwn_max = squeeze(ut_3D(:,198,:));

vt_alo_max = squeeze(vt_3D(:,180,:));
vt_bwn_max = squeeze(vt_3D(:,212,:));
vt_up = squeeze(vt_3D(:,104,:));
vt_1d = squeeze(vt_3D(:,158,:));
vt_3d = squeeze(vt_3D(:,184,:));
vt_5d = squeeze(vt_3D(:,210,:));
vt_10d =squeeze(vt_3D(:,275,:));
vt_20d = squeeze(vt_3D(:,405,:));

[Mut_alo,Iut_alo] = max(ut_alo(:));
[Xut_alo,Yut_alo] = ind2sub(size(ut_alo),Iut_alo);

[Mut_bwn,Iut_bwn] = max(ut_bwn(:));
[Xut_bwn,Yut_bwn] = ind2sub(size(ut_bwn),Iut_bwn);

[Mvt_alo,Ivt_alo] = max(vt_alo(:));
[Xvt_alo,Yvt_alo] = ind2sub(size(vt_alo),Ivt_alo);

[Mvt_bwn,Ivt_bwn] = max(vt_bwn(:));
[Xvt_bwn,Yvt_bwn] = ind2sub(size(vt_bwn),Ivt_bwn);

[Muv_alo,Iuv_alo] = max(uv_alo(:));
[Xuv_alo,Yuv_alo] = ind2sub(size(uv_alo),Iuv_alo);

[Muv_bwn,Iuv_bwn] = max(uv_bwn(:));
[Xuv_bwn,Yuv_bwn] = ind2sub(size(uv_bwn),Iuv_bwn);



% utemp_bwn=figure;
% str = {'holes','1D','3D','5D','10D','20D'};
% set(gcf,'Units','inches','Position',[0 0 11 7]);
% pcolor(X,Y,ut_bwn(:,1:98)');
% % contourf(X,Y,ut_bwn(:,1:98)');
% % hold on
% % line(x1,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% xlabel('x^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% xticks([xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)]);
% xticklabels(str);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
% ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% % xlim([0 1200])
% % ylim([0 400])
% shading interp;
% % daspect([1 1 1]);
% colormap(jet);
% c=colorbar;
% caxis([0 12]);
% % set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% % saveas(utemp_bwn,'ut_bwn_XY.png');
% 
% 
% utemp_alo=figure;
% str = {'holes','1D','3D','5D','10D','20D'};
% set(gcf,'Units','inches','Position',[0 0 11 7]);
% pcolor(X,Y,ut_alo(:,1:98)');
% % contourf(X,Y,ut_alo(:,1:98)');
% % hold on
% % line(x1,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% xlabel('x^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% xticks([xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)]);
% xticklabels(str);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
% ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% % xlim([0 1200])
% % ylim([0 400])
% shading interp;
% % daspect([1 1 1]);
% colormap(jet);
% c=colorbar;
% caxis([0 12]);
% % set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% % saveas(utemp_bwn,'ut_bwn_XY.png');
% 
% vtemp_alo=figure;
% str = {'holes','1D','3D','5D','10D','20D'};
% set(gcf,'Units','inches','Position',[0 0 11 7]);
% pcolor(X,Y,vt_alo(:,1:98)');
% % contourf(X,Y,vt_alo(:,1:98)');
% % hold on
% % line(x1,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% xlabel('x^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% xticks([xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)]);
% xticklabels(str);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
% ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% % xlim([0 1200])
% % ylim([0 400])
% shading interp;
% % daspect([1 1 1]);
% colormap(jet);
% c=colorbar;
% caxis([0 6]);
% % set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% % saveas(utemp_bwn,'ut_bwn_XY.png');
% 
% vtemp_bwn=figure;
% str = {'holes','1D','3D','5D','10D','20D'};
% set(gcf,'Units','inches','Position',[0 0 11 7]);
% pcolor(X,Y,vt_bwn(:,1:98)');
% % contourf(X,Y,vt_bwn(:,1:98)');
% % hold on
% % line(x1,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% xlabel('x^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% xticks([xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)]);
% xticklabels(str);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
% ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% % xlim([0 1200])
% % ylim([0 400])
% shading interp;
% % daspect([1 1 1]);
% colormap(jet);
% c=colorbar;
% caxis([0 6]);
% % set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% % saveas(utemp_bwn,'ut_bwn_XY.png');
% 
% uv_along=figure;
% str = {'holes','1D','3D','5D','10D','20D'};
% set(gcf,'Units','inches','Position',[0 0 11 7]);
% pcolor(X,Y,uv_alo(:,1:98)');
% % contourf(X,Y,vt_bwn(:,1:98)');
% % hold on
% % line(x1,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% xlabel('x^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% xticks([xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)]);
% xticklabels(str);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
% ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% % xlim([0 1200])
% % ylim([0 400])
% shading interp;
% % daspect([1 1 1]);
% colormap(jet);
% c=colorbar;
% caxis([0 10]);
% % set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% % saveas(utemp_bwn,'ut_bwn_XY.png');
% 
% uv_bwnf=figure;
% str = {'holes','1D','3D','5D','10D','20D'};
% set(gcf,'Units','inches','Position',[0 0 11 7]);
% pcolor(X,Y,uv_bwn(:,1:98)');
% % contourf(X,Y,vt_bwn(:,1:98)');
% % hold on
% % line(x1,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% hold on
% line(x6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
% xlabel('x^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% xticks([xplus(145) xplus(158) xplus(184) xplus(210) xplus(275) xplus(405)]);
% xticklabels(str);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
% ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
% set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% % xlim([0 1200])
% % ylim([0 400])
% shading interp;
% % daspect([1 1 1]);
% colormap(jet);
% c=colorbar;
% caxis([0 10]);
% % set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% % saveas(utemp_bwn,'ut_bwn_XY.png');

zl=[zplus(28) zplus(62) zplus(96) zplus(130) zplus(164)];
yl=[0 yplus(98)];

% x1=[xl(1) xl(1)];
z2=[zl(1) zl(1)];
z3=[zl(2) zl(2)];
z4=[zl(3) zl(3)];
z5=[zl(4) zl(4)];
z6=[zl(5) zl(5)];

utup=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_up(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

ut1d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_1d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

ut3d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_3d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

ut5d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_5d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

ut10d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_10d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

ut20d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_20d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

utalmax=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_alo_max(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

utbnmax=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,ut_bwn_max(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 12]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');





vtup=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_up(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vt1d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_1d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vt3d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_3d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vt5d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_5d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vt10d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_10d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vt20d=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_20d(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vtalmax=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_alo_max(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');

vtbnmax=figure;
%str = {'holes','1D','3D','5D','10D','20D'};
set(gcf,'Units','inches','Position',[0 0 11 7]);
pcolor(Z,Y_,vt_bwn_max(:,1:98)');
% contourf(X,Y,vt_bwn(:,1:98)');
hold on
line(z2,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z3,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z4,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z5,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
line(z6,yl,'Color','black','LineStyle','--','LineWidth',1.5);
hold on
xlabel('z^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
%xticks([zplus(145) zplus(158) zplus(184) zplus(210) zplus(275)]);
% xticklabels(str);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',9)
ylabel('y^{+}','FontName','Times','FontSize',20,'FontAngle','italic');
set(gca,'FontName','Times','FontSize',20,'FontAngle','italic');
% xlim([0 1200])
% ylim([0 400])
shading interp;
% daspect([1 1 1]);
colormap(jet);
c=colorbar;
caxis([0 6]);
% set(c,'FontName','Times','FontSize',14,'FontAngle','italic');
% saveas(utemp_bwn,'ut_bwn_XY.png');
