sddsprocess comm.out.e2g.br "-redefine=column,t, t 1e15 *"
#sddsprocess comm.out.e2g.br -define=column,betax,"xrms sqr xemit / gamma *" \
#  -define=column,betay,"yrms sqr yemit / gamma *"\
#  -define=column,rdgam,"dgamma gamma /"

sddsplot -layout=2,2,limitPerPage=4 -xLabel="bunch duration (s)" -split=pages \
-graph=line,vary -unsuppressZero \
-column=t,xemit comm.out.e2g.br -yscale=id=1 -graph=line,type=1 -yLabel="enx eny (m)" -legend,specified=enx \
-column=t,yemit comm.out.e2g.br -yscale=id=1 -graph=line,type=2 -legend,specified=eny \
-tickSettings=yscaleChars=1,yfactor=1e6 \
        -title="norm. Emitance (Rms)",scale=1 -topTitle \
        -endPanel \
-column=t,xrms comm.out.e2g.br -yscale=id=1 -graph=line,type=3 -yLabel="xrms yrms (m)" -legend,specified=xrms \
        -column=t,yrms comm.out.e2g.br -yscale=id=1 -graph=line,type=4 -legend,specified=yrms \
        -tickSettings=yscaleChars=1,yfactor=1e6 \
-title="Beam Size (Rms)",scale=1 -topTitle \
        -endPanel \
-column=t,xavg  -yscale=id=1 -graph=line,type=5 -yLabel="Avex Avey (m)" -legend comm.out.e2g.br \
        -column=t,yavg  -yscale=id=1 -graph=line,type=6 -legend comm.out.e2g.br \
        -tickSettings=yscaleChars=1 \
-title="Slice Average",scale=0.7 -topTitle \
        -endPanel \
        -column=t,alphax comm.out.e2g.br -yscale=id=1 -graph=line,type=5 -yLabel="Alphax Alphay" -legend,specified=alphax \
        -column=t,alphay comm.out.e2g.br -yscale=id=1 -graph=line,type=6 -legend,specified=alphay \
        -title="Slice Alphas",scale=1 -topTitle \
        -endPanel

sddsplot -graph=line,vary -xLabel="bunch duration (s)" -split=pages \
-column=t,current comm.out.e2g.br -yscale=id=2 -yLabel="I (A)" -legend\
-column=t,dgamma comm.out.e2g.br -yscale=id=1 -yLabel="se(dg)" -legend

sddsplot -graph=line,vary -xLabel="bunch duration (s)" -split=pages \
-column=t,current comm.out.e2g.br -yscale=id=2 -yLabel="I (A)" -legend\
-column=t,gamma comm.out.e2g.br -yscale=id=1 -yLabel="se(dg)" -legend
