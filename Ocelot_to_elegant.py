# partilce input file from Ocelot to ELGANT

import os
#os.system('cd c:/Users/NSMIRIAN/Downloads/Wake_files')
#cd 'C:/Users/NSMIRIAN/Downloads/Wake_files'

import numpy as np
#import seaborn as sns
import matplotlib.pyplot as plt
#%matplotlib inline
import matplotlib.mlab as mlab
#import matplotlib.pyplot as plt
#beam=np.loadtxt("C:/cygwin/home/NSMIRIAN/FEL19/out.ast")

beam=np.load('injection_gun_beamm.npz')
x=beam['rparticles'][0,:]
px=beam['rparticles'][1,:]
y=beam['rparticles'][2,:]
py=beam['rparticles'][3,:]
z=beam['rparticles'][4,:]
p=beam['rparticles'][5,:]+beam["E"]/0.51e-3
ID=np.arange(1,100001, dtype=np.uint64)
t=z/3e8



# Then you map to the grid
#g = sns.PairGrid(iris)
#.map(plt.scatter)
N=len(x)
inj=np.zeros((N,7))
inj[:,0]=ID
inj[:,1]=x
inj[:,2]=px
inj[:,3]=y
inj[:,4]=py
inj[:,5]=t
inj[:,6]=p
#file1 = open("out.sdds","w")
np.savetxt("particle_file.csv", inj,  delimiter=' ')

'''
SDDS5
&description text="injection beam phase space", &end
&column name=particleID, type=ulong64,  &end
&column name=x, units=m, type=double,  &end
&column name=xp, symbol=x', type=double,  &end
&column name=y, units=m, type=double,  &end
&column name=yp, symbol=y', type=double,  &end
&column name=t, units=s, type=double,  &end
&column name=p, units="m$be$nc", type=double,  &end



&column name=ID, description="particle index", format_string=%6ld, type=long,  &end'
&column name=x, symbol=x, units=m, description="horizontal position", format_string=%12.5e, type=double,  &end'
&column name=xp, symbol=x' ',', description="horizontal slope", format_string=%12.5e, type=double,  &end'
&column name=y, symbol=y, units=m, description="vertical position", format_string=%12.5e, type=double,  &end'
&column name=yp, symbol=y' ',', description="vertical slope", format_string=%12.5e, type=double,  &end'
&column name=t, symbol=t, units=s, description="time", format_string=%12.5e, type=double,  &end'
&column name=p, symbol=p, units=m$be$nc, description="momentum", format_string=%12.5e, type=double,  &end'
&data mode=ascii, no_row_counts=1, &end' 
'''
