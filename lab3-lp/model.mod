# MPSiS 2018/2019
# Model UFAP, L-P

#based on https://upel.agh.edu.pl/wiet/pluginfile.php/39003/mod_resource/content/1/mpsis_konspekt_w3.pdf point no. 9
#and previous work by Konrad Adamczyk


/* Number of vertexes, edges, dispositions */
param E_count, integer, >= 0;
param D_count, integer, >= 0;
param P_count, integer, >= 0; /* don't know what about the index from conspect lecture 2 ufap L-P */

/* Sets of vertexes, edges and dispositions */
set E, default {1..E_count};
set D, default {1..D_count};
set P, default {1..P_count};

/* Requirements */
param delta{e in E, d in D, p in P}
param h{d in D} >= 0;
param KSI{e in E} >= 0;

/* Decision variables */
var x{d in D, p in P} >= 0;

/* Objective function 'z' */
minimize z: sum{e in E} KSI[e]*(sum{d in D} (sum{p in P} (delta[e,d,p]*x[d,p])));

/* Constraints */
s.t. c1{d in D} : sum{p in P} x[d,p] == h[d];
