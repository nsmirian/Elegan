clear;clc;
file='run.0.s1.gout.dpa'
gamma0=27311.1772088% delgamma=2.93500E-01%8.00E-1;
npart=8192; % number of macro particles
%xpoints=30; % number of grid points in x direction
nslice=4895;
lambda=  1.3776021932934132e-10;
k=2*pi/lambda;
% file='mod.out.dpa'; % open particle file and read rada
fid=fopen(file,'r');
for i=1:nslice/10
gamma(:,i) = fread(fid, npart, 'double');
theta(:,i) = fread(fid, npart, 'double')/k+(i-1)*9*lambda;
x(:,i)= fread(fid, npart, 'double');
y(:,i)= fread(fid, npart, 'double');
px(:,i) = fread(fid, npart, 'double');
py(:,i) = fread(fid, npart, 'double');
 
g(:)=fread(fid, 9*npart, 'double');
g(:)= fread(fid, 9*npart, 'double')/k+(i-1)*lambda;
g(:)=fread(fid, 9*npart, 'double');
g(:)= fread(fid, 9*npart, 'double');
g(:)= fread(fid, 9*npart, 'double');
g(:)= fread(fid, 9*npart, 'double');
 
 
end
fclose(fid);
%%
c=3e8;
gamma2 = reshape(gamma.',1,[]);
z=reshape(theta.',1,[]);
Out(:,1) = reshape(x.',1,[]);
Out(:,3)= reshape(y.',1,[]);
Out(:,2) = reshape(px.',1,[])/gamma0;
Out(:,4) = reshape(py.',1,[])/gamma0;
Out(:,6)=gamma2;
Out(:,5)=z/c;
 
%%
figure()
fontsize=20;
plot(z,gamma2,'.','markers',1)
 
%%
 
writematrix(Out,'out.csv')
 
 
 
