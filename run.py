"""
---------------------------
Runing Elegan with new input file and using sdd to visualise the results
June. 2020
----------------------------
"""
import os
os.system('clear')
import numpy as np
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import pandas as pd
import random
os.system('rm -rf  *.cen *.flr *.mag *.mpr *.twi *.sig  *.par *.mat  *.out *.new')



#----------------------------------------------------------

def Mtrix_elem(Rphi, K, L ):
	
	KL2= K*L/2*np.cos(Rphi)
	K2L6=K**2 *L/6 *np.cos(Rphi)
	Kv=K*np.cos(Rphi)
#print(K, K*L/2, K**2 *L/6)
	AK=K
	AKL2=K*L/2

	S13='% '+ repr(Kv)+ '	sto  K		! e0*V0*k/(pc) cos(phi)\n'
	S14='% '+ repr(KL2)+ '	sto  KL2	! KL/2 cos(phi)\n'
	S15='% '+ repr(K2L6)+ '	sto  K2L6	! K^2L/6 cos(phi)\n'
	S16='% '+ repr(5.000000)+ '	sto  L		! length of the TDS\n'
	S17='% '+ repr(AK)+ '	sto  AK		! e0*V0*k/(pc)\n'
	S18='% '+ repr(AKL2)+ '	sto  AKL2	! KL/2\n'

	my_file = "lat02.lat"

	with open(my_file, 'r') as file:
    		lines = file.readlines()
#now we have an array of lines. If we want to edit the line 13...
	line_to_replace =13
	if len(lines) > line_to_replace:
    		lines[line_to_replace] = S13

	line_to_replace =14
	if len(lines) > line_to_replace:
    		lines[line_to_replace] = S14

	line_to_replace =15
	if len(lines) > line_to_replace:
   		lines[line_to_replace] =S15

	line_to_replace =16
	if len(lines) > line_to_replace:
    		lines[line_to_replace] = S16
	line_to_replace =17
	if len(lines) > line_to_replace:
    		lines[line_to_replace] =S17

	line_to_replace =18
	if len(lines) > line_to_replace:
    		lines[line_to_replace] = S18
	line_to_replace =19

	with open(my_file, 'w') as file:
    		file.writelines( lines )
	return

#-----------------------------------------------------

def ElegantRun(Rphi, K, L ):
	Mtrix_elem(Rphi, K, L )
	os.system('elegant lat02.ele')

	

#------------------
	os.system('elegant tracking.ele > eleg.txt')
	#os.system('sddshist2d  final.sdds final.out -columns=x,y -xparameters=255 -yparameters=255')
	#os.system('sddscontour final.out -shades=26')# -device=png -output=ph_sp.png')


	os.system('sddsprintout tracking.sig -col=Sx -col=Sy data.sig')
	data_sig= np.loadtxt("data.sig",skiprows=10)
	[sigx, sigy]= data_sig[-1,:] 

	return sigx, sigy
#------------------------------------------------------
e0=1	#.62e-19
m0=0.51e6    #eV
c0=3e8       # light velocity 
pi=3.14

V0=150e6	# TDS Rf voltage [v]
L=5;
freq=12e9	# RF frequency
k=2*pi*freq/c0
lambdaRf=c0/freq
E0=14e9
#R34=
pc=14e9
gamma0=pc/m0

Rphi=0.0
K=e0*V0*k/(pc)



[sigx1, sigy1]=ElegantRun(0.0, K, L )
[sigx2, sigy2]=ElegantRun(pi, K, L )
[sigx3, sigy3]=ElegantRun(pi, K/2, L )
[sigx4, sigy4]=ElegantRun(0.0, K/2, L )
[sigx5, sigy5]=ElegantRun(0.0, 0.0, L )

os.system('clear')
X=[0, V0/2, -V0/2, V0, -V0]
sigx=[sigx5**2, sigx4**2, sigx3**2, sigx1**2, sigx2**2]

z = np.polyfit(X, sigx, 2)
print(z)
#-------------------------------------
#os.system('sddsprintout  tracking.mat -col=R12 R12.dat')
#MatrixR12= np.loadtxt("R12.dat",skiprows=10)
#R12= MatrixR12[-1] 
os.system('sddsprintout  lat02_3.twi -col=ElementName -col=betax -col=psix betas.txt ')
#Betas=np.loadtxt("R12.dat",skiprows=5)
#Beta1=Betas[-1,0]
df=pd.read_csv('betas.txt', header=1, delimiter='\s+')
Beta0=float(df['betax'][17])
Beta1=float(df['betax'][45])
psix=float(df['psix'][45])

#R12=6.757088e+01 

R12=np.sqrt(Beta0*Beta1)*np.sin(psix)
print(R12)
sigmaz=np.sqrt(z[0])*E0*lambdaRf/(R12 *2*pi)
print(sigmaz)
p = np.poly1d(z)
xp = np.linspace(-V0, V0, 20)

#-----------------------------------------
file3=open("sigmax.dat",'w')
np.savetxt(file3,  X, fmt ='%-7.4f,', delimiter=',',newline='')
file3.write(" \n") 
np.savetxt(file3,  sigx, fmt ='%-7.8f,', delimiter=',',newline='')
file3.write(" \n") 

#-----------------------------------------------
os.system('sddsplot -graph=line,vary -col=s,beta? -yscale=id=1 lat02_3.twi -legend\
		-col=s,eta? -yscale=id=2 lat02_3.twi -legend ')

#txt='a ='+repr('{:.2f}'.format( z[0]))+ ',\t b='+repr('{:.2f}'.format(z[1]))+',\t c='+repr('{:.2f}'.format(z[2]))
txt='[a, b, c]='+repr(z)
txt2='\$\sigma_z=$'+repr(sigmaz)

a=float(-V0)
b=float(sigx4**2*2)
plt.figure(2)
ax1 = plt.subplot(111)

ax1.plot( X, sigx, 'or',label='sigx')
ax1.plot( xp, p(xp), '--',label='fit')
ax1.text(a,b , txt)
ax1.text(a,2*b,txt2)

plt.ylabel('sigma_z')
plt.xlabel('RF voltage')
plt.legend()



num=random.randint(0, 50)
filename='fiting'+repr(num)+'.png'

plt.savefig(filename)

plt.show()



