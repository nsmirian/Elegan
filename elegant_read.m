clear all

 %fid1=fopen('C:\cygwin64\home\najmeh.mirian\FERMI\ASML\bc0.085\1<slicek9.txt');
 %  fid1=fopen('C:\cygwin64\home\najmeh.mirian\FERMI\ASML\bc0.0851\slicel9.txt');
  %  fid1=fopen('C:\cygwin64\home\najmeh.mirian\FERMI\ASML\bc0.0851\slicek0.txt')
fid1=fopen('C:\cygwin64\home\najmeh.mirian\FERMI\TH_fermi\tera.txt ')
%fopen('C:\cygwin64\home\najmeh.mirian\FERMI\ASML\SIMONE\simone\slic5.txt')
%'C:\cygwin64\home\najmeh.mirian\FERMI\ASML\manipolating\slic1.txt')

%   fid1=fopen('C:\cygwin64\home\najmeh.mirian\FERMI\ASML\lawK4\slic3.txt')

while strcmp(sscanf(fgets(fid1),'%s', 1),'260')==0; %skip header and other lines
  end
DataV=fscanf(fid1,'%f',[19,inf]);
Z=DataV(2,:);
energy=DataV(3,:);
sigmaenergy=DataV(4,:);
emitx=DataV(6,:);
emity=DataV(7,:);
rmsx=DataV(8,:);
rmsy=DataV(9,:);
posx=DataV(10,:);
posy=DataV(11,:);
current=DataV(16,:);

esp=DataV(16,:);
% sizet=size(time)
% sizefine=10*(sizet(1,2)-1)+1;
% xfine=linspace(0,max(Z),sizefine);
% zfine=linspace(0,max(time),sizefine);
figure()
subplot(3,2,1)
fw=0.0%abs(fwhm(Z*10^12,current));
rm=mean(current)
plot(Z,current,'LineWidth',1);
%plot(period*100,heating, 'LineWidth',4)
title(['FWHM=',num2str(fw),'ps', ', rms=', num2str(rm)],'fontsize',8)
ylabel('Current (A)','interpreter','latex','fontsize',10);
xlabel('t (ps)','interpreter','latex','fontsize',10);
%figure(1)
subplot(3,2,3)
plot(Z,energy*0.511,'LineWidth',1)
xlabel('t (ps)','interpreter','latex','fontsize',10);
ylabel('energy (MeV)','interpreter','latex','fontsize',10);

%ylim([760 765.5])
% figure(1)
subplot(3,2,5)
plot(Z,sigmaenergy*511,'LineWidth',1)
xlabel('t (ps)','interpreter','latex','fontsize',10);
ylabel('energy spread (keV)','interpreter','latex','fontsize',10);
maxe=max(sigmaenergy*511)
rme=mean(sigmaenergy*511)
title(['max=',num2str(maxe),'fs', ', rms=', num2str(rme)],'fontsize',8)
subplot(3,2,2)
[hAx,hLine1,hLine2]=plotyy(Z*10^12,emitx,Z*10^12,emity)

% hold on
% plot(Z*10^15,emity,'LineWidth',2)
 xlabel('t (ps)','interpreter','latex','fontsize',10);
 ylabel(hAx(1),'Emittance_x (mm-mrad)','interpreter','latex','fontsize',10);
 ylabel(hAx(2),'Emittance_y (mm-mrad)','interpreter','latex','fontsize',10);
% hold off
%figure(2)
subplot(3,2,4)
[hAx,hLine1,hLine2]=plotyy(Z*10^12,rmsx*10^6,Z*10^12,posx*10^6)

xlabel('t (ps)','interpreter','latex','fontsize',10);
 ylabel(hAx(1),'x(\mum)','fontsize',10);
 ylabel(hAx(2),'x^{\prime}','fontsize',10);
%hold off
%figure(2)
subplot(3,2,6)
[hAx,hLine1,hLine2]=plotyy(Z*10^12,rmsy*10^6,Z*10^12,posy*10^6)
% hold on
%plot(Z*10^15,posy*10^6,'LineWidth',2)
xlabel('t (ps)','interpreter','latex','fontsize',10);

ylabel(hAx(1),'y(\mum)','fontsize',10);
 ylabel(hAx(2),'y^{\prime}','fontsize',10);
legend
hold off
% pp=spline(Z,wake);
fclose('all')
