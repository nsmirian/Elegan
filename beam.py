
import os
#os.system('cd c:/Users/NSMIRIAN/Downloads/Wake_files')
#cd 'C:/Users/NSMIRIAN/Downloads/Wake_files'

import numpy as np
#import seaborn as sns
import matplotlib.pyplot as plt
#%matplotlib inline
import matplotlib.mlab as mlab
#import matplotlib.pyplot as plt
beam=np.loadtxt("C:/cygwin/home/NSMIRIAN/FEL19/out.ast")

x=beam[1:,0]
y=beam[1:,1]
z=beam[1:,2]
px=beam[1:,3]/0.51e6
py=beam[1:,4]/0.51e6
p=beam[1:,5]/0.51e6 + beam[0,5]/0.51e6
minz=min(z)
maxz=max(z)
t=z/3e8;

plt.figure(2)
plt.rcParams.update({'font.size': 14})
plt.subplot(2,2,1)
l1=plt.scatter(x/1e-6, y/1e-6, s=1)
plt.ylim(-50, 50)
plt.xlim(-50, 50)
plt.xlabel('x($\mu$m)')
plt.ylabel('y($\mu$m)')
plt.subplot(2,2,2)
l2=plt.scatter(x/1e-6, px, s=1)
plt.xlim(-60, 60)
#plt.xlim(minz, maxz)
plt.xlabel('x($\mu$m)')
plt.ylabel('px')
plt.subplot(2,2,3)
l3=plt.scatter(z/1e-6, x/1e-6, s=1)
plt.xlim(minz/1e-6, maxz/1e-6)
plt.ylim(-60, 60)
plt.ylabel('x($\mu$m)')
plt.xlabel('z($\mu$m)')
plt.subplot(2,2,4)
l4=plt.scatter(z/1e-6, p*0.51e6/1e9, s=1)
plt.xlim(minz/1e-6, maxz/1e-6)
plt.subplots_adjust(left=0.15, bottom=0.2, right=None, top=None, \
wspace=0.5, hspace=0.5)
plt.xlabel('z($\mu$m)')
plt.ylabel('E(GeV)')

# Then you map to the grid
#g = sns.PairGrid(iris)
#.map(plt.scatter)
N=len(x)
inj=np.zeros((N,6))
inj[:,0]=x
inj[:,1]=px
inj[:,2]=y
inj[:,3]=py
inj[:,4]=t
inj[:,5]=p
#file1 = open("out.sdds","w")
np.savetxt("C:/cygwin/home/NSMIRIAN/FEL19/out.csv", inj,  delimiter=',')
#np.savetxt(file1, inj )
plt.show()