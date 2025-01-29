clc
clear
% preperation input file for elegant

fid1=fopen('C:\cygwin64\home\najmeh.mirian\FERMI\50pc\Secondo\flat50_one-bunch4.txt_ele2.sdds')

while strcmp(sscanf(fgets(fid1),'%s', 1),'!')==0; %skip header and other lines
  end
DataV=fscanf(fid1,'%f',[7,inf]);
ID=DataV(1,:);
x=DataV(2,:);
xp=DataV(3,:);
y=DataV(4,:);
yp=DataV(5,:);
t=DataV(6,:)/8;
p=DataV(7,:);
hist(t)

 fid   = fopen('C:\cygwin64\home\najmeh.mirian\FERMI\50pc\Secondo\fifth.sdds','w');
%fprintf(fid,'%s\r\n','SDDS1');
%  fprintf(fid, '%s\r\n','&description text="filename", &end')
%  fprintf(fid, '%s\r\n','&column name=ID, description="particle index", format_string=%6ld, type=long,  &end')
%  fprintf(fid, '%s\r\n','&column name=x, symbol=x, units=m, description="horizontal position", format_string=%12.5e, type=double,  &end')
%  fprintf(fid, '%s\r\n','&column name=xp, symbol=x' ',', description="horizontal slope", format_string=%12.5e, type=double,  &end' )
%  fprintf(fid, '%s\r\n','&column name=y, symbol=y, units=m, description="vertical position", format_string=%12.5e, type=double,  &end'))
%  fprintf(fid, '%s\r\n','&column name=yp, symbol=y' ',', description="vertical slope", format_string=%12.5e, type=double,  &end' )
%  fprintf(fid, '%s\r\n','&column name=t, symbol=t, units=s, description="time", format_string=%12.5e, type=double,  &end')
%  fprintf(fid, '%s\r\n','&column name=p, symbol=p, units=m$be$nc, description="momentum", format_string=%12.5e, type=double,  &end')
%  fprintf(fid, '%s\r\n','&data mode=ascii, no_row_counts=1, &end')
%fprintf(fid, '%s\r\n','! page number 1');
%fprintf(fid, '%s %s\r\n','? COLUMNS ZPOS' , ' PRAD0');
fprintf(fid, '%d % e % e % e % e % e % f\r\n' ,[ID(1:200000); x(1:200000) ; xp(1:200000) ; y(1:200000); yp(1:200000); t(1:200000); p(1:200000)],  'double');
%plot(s(:,1),s(:,2))
 %fid11   = fopen('C:\cygwin64\home\najmeh.mirian\FERMI\50pc\Secondo\second50pc7.sdds','w');
%fprintf(fid,'%s\r\n','SDDS1');
%  fprintf(fid, '%s\r\n','&description text="filename", &end')
%  fprintf(fid, '%s\r\n','&column name=ID, description="particle index", format_string=%6ld, type=long,  &end')
%  fprintf(fid, '%s\r\n','&column name=x, symbol=x, units=m, description="horizontal position", format_string=%12.5e, type=double,  &end')
%  fprintf(fid, '%s\r\n','&column name=xp, symbol=x' ',', description="horizontal slope", format_string=%12.5e, type=double,  &end' )
%  fprintf(fid, '%s\r\n','&column name=y, symbol=y, units=m, description="vertical position", format_string=%12.5e, type=double,  &end'))
%  fprintf(fid, '%s\r\n','&column name=yp, symbol=y' ',', description="vertical slope", format_string=%12.5e, type=double,  &end' )
%  fprintf(fid, '%s\r\n','&column name=t, symbol=t, units=s, description="time", format_string=%12.5e, type=double,  &end')
%  fprintf(fid, '%s\r\n','&column name=p, symbol=p, units=m$be$nc, description="momentum", format_string=%12.5e, type=double,  &end')
%  fprintf(fid, '%s\r\n','&data mode=ascii, no_row_counts=1, &end')
%fprintf(fid, '%s\r\n','! page number 1');
%fprintf(fid, '%s %s\r\n','? COLUMNS ZPOS' , ' PRAD0');
% fprintf(fid11, '%d % e % e % e % e % e % f\r' ,[ID(199970:200000); x(199970:200000) ; xp(199970:200000)...
%     ; y(199970:200000); yp(199970:200000); t(199970:200000); p(199970:200000)],  'double');
%plot(s(:,1),s(:,2))
fclose('all')