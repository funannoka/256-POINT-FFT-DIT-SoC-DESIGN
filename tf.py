#!/usr/bin/python

import sys
import time
import os
import subprocess
import socket
import argparse
import cmath
import math
from string import find

def makeoutpipe(fn,N):
  fp = open(fn,"w")
  for i in range(0,N):
    fp.write("\t\trd_bufb_d[{1}] <= rd_bufb_d[{0}];\n\t\tbfpushout_d[{1}] <= bfpushout_d[{0}];\n".format(i,i+1))
    fp.write("\t\tdoneb_prev[{1}] <= doneb_prev[{0}];\n\t\tstage_eightb_prev[{1}] <= stage_eightb_prev[{0}];\n".format(i,i+1))
    fp.write("\t\touteven_indexb_d[{1}] <= outeven_indexb_d[{0}];\n\t\toutodd_indexb_prev[{1}] <= outodd_indexb_prev[{0}];\n".format(i,i+1))
    fp.write("\t\tbreal_d[{1}] <= breal_d[{0}];\n\t\tbimag_d[{1}] <= bimag_d[{0}];\n".format(i,i+1))
  fp.close()
def makebfPipe(fn,N):
  fp = open(fn,"w")
  for i in range(0,N):
    fp.write("\t\tvalid[{1}] <= #1 valid[{0}];\n\t\tcntrl_d[{1}] <= #1 cntrl_d[{0}];\n".format(i+5,i+6))
    fp.write("\t\ts1_re[{1}] <= #1 s1_re[{0}];\n\t\ts1_im[{1}] <= #1 s1_im[{0}];\n".format(i,i+1))
    fp.write("\t\ts2_re[{1}] <= #1 s2_re[{0}];\n\t\ts2_im[{1}] <= #1 s2_im[{0}];\n".format(i,i+1))
  fp.close()
def makepipereg(fn,N):
  fp = open(fn,"w")
  for i in range(0,N):
    fp.write("\t\tbfpush[{1}] <= #1  bfpush[{0}];\n\t\ttfrl[{1}] <= #1 tfrl[{0}];\n\t\ttfim[{1}] <= #1 tfim[{0}];\n\t\trl1[{1}] <= #1 rl1[{0}];\n\t\tim1[{1}] <= #1 im1[{0}];\n\t\trl2[{1}] <= #1 rl2[{0}];\n\t\tim2[{1}] <= #1 im2[{0}];\n\t\tcntrl1[{1}] <= #1 cntrl1[{0}];\n".format(i,i+1))
    #fp.write("\t\tpushout[{1}] <= #1 pushout[{0}];\n\t\trealpipe[{1}] <= #1 realpipe[{0}];\n\t\timagpipe[{1}] <= #1 imagpipe[{0}];\n".format(i,i+1))
   # fp.write("\tbfx0real{0}_p[0] =  bfx0real{0};\n\tbfx0imag{0}_p[0] =  bfx0imag{0};\n\tbfx1real{0}_p[0] = bfx1real{0};\n\tbfx1imag{0}_p[0] = bfx1imag{0};\n\tcntrl_in{0}_p[0] = cntrl_in{0};\n\ttfreal{0}_p[0] = tfreal{0};\n\ttfimag{0}_p[0] = tfimag{0};\n\tbfpushin{0}_p[0] = bfpushin{0};\n\n".format(i))
  fp.close()
def makepipe2reg(fn,st,N):
  fp = open(fn,"w")
  for i in range(1,st):
    for x in range(0,N):
      fp.write("\t\trd_p{2}[{1}] <= #1 rd_p{2}[{0}];\n\t\tbrealp{2}[{1}] <= #1 brealp{2}[{0}];\n\t\tbimagp{2}[{1}] <= #1 bimagp{2}[{0}];\n\t\toddbrealp{2}[{1}] <= #1 oddbrealp{2}[{0}];\n\t\toddbimagp{2}[{1}] <= #1 oddbimagp{2}[{0}];\n\t\teindexp{2}[{1}] <= #1 eindexp{2}[{0}];\n\t\toindexp{2}[{1}] <= #1 oindexp{2}[{0}];\n\t\tdoneb_prev[{1}] <= #1 doneb_prev[{0}];\n\t\tpush{2}[{1}] <= #1 push{2}[{0}];\n".format(x,x+1,i)) 
    fp.write("\n\n")
  fp.close()
def makeTwiddleFile(fn,N,width):
  fp = open(fn,"w")
  nlog2 = int(math.log(N,2))
  fp.write("module tf ( \n")
  fp.write("input clk,\n")
  fp.write("input [{0}:0] indexbfly,\n".format(nlog2-2))
  fp.write("input enable,\n")
  fp.write("output reg signed [{0}:0] outreal,\noutput reg signed [{0}:0]outimag);\n".format(width-1))
  fp.write("""always @ (posedge (clk)) begin
if (enable)
begin
case (indexbfly)
""")
  for i in range(0,N/2):
    w = cmath.exp(-i*2j*cmath.pi/N)
    maxval = pow(2,width-2)
    if w.real > 0:
      rsign = ""
    else:
		  rsign = "-"
		  w = -w.real + (0+1j)*w.imag
    if w.imag > 0:
      isign = ""
    else:
      isign = "-"
      w = w.real - (0+1j)*w.imag
    tfsize = str(int(width))
    if w.real < 0 or w.real > 1:
      raise ValueError("wreal must be between 0 and 1")
    if w.imag < 0 or w.imag > 1:
      raise ValueError("wimag must be between 0 and 1")
    re =""
    im =""
    re = str(int(round(w.real * maxval)))
    im = str(int(round(w.imag * maxval)))
    tfreal = "%s%s'sd%s"%(rsign,tfsize,re)
    tfimag = "%s%s'sd%s"%(isign,tfsize,im)
   # fp.write("    real = {0} imag = {0}\n".format(tfreal,tfimag))	
    fp.write("    {0}'d{1}:\n\t\tbegin\n\t\t\toutreal <= {2};\n\t\t\toutimag <= {3};\n\t\tend\n".format(nlog2-1,i,tfreal,tfimag))
  fp.write("    default:\n\t\tbegin\n\t\t\toutreal <= {0}'d0;\n\t\t\toutimag <= {0}'d0;\n\t\tend\n".format(width))	
  fp.write("""   endcase
end
end
endmodule
""")
  fp.close()
  
def mainx():
  makeTwiddleFile("twiddlefactor.v",256,20)	
  #makepipereg("outpipe.v",128);
  #makepipe2reg("inbuffpipe.v",9,128)
  #makebfPipe("bfpipe.v",512)	
 # makeoutpipe("outpipe.v",129)	
mainx()
