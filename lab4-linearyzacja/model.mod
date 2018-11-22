/* MPSiS 2018/2019 */
/* Model UFAP, N/L */

/* Number of vertexes, edges, dispositions */
param V_count, integer, >= 0;
param E_count, integer, >= 0;
param D_count, integer, >= 0;

/* Number if segments */
param S_count, integer, >= 0;

/* Big number W */
param W, integer, >= 0, default 100000000000;

/* Sets of vertexes, edges and dispositions */
set V, default {1..V_count};
set E, default {1..E_count};
set D, default {1..D_count};

set S, default {1..S_count};

/* Requirements */
param h{d in D} >= 0;
param s{d in D} >= 0;
param t{d in D} >= 0;

/* Params to linearization */
param a{seg in S} >= 0;
param b{seg in S} >= 0;

/* Aev, Bev as params */
param A{e in E, v in V}, >= 0, default 0;
param B{e in E, v in V}, >= 0, default 0;

/* Decision variables */
var x{e in E, d in D} >= 0;
var u{e in E, seg in S}, binary;
var m{e in E, seg in S} >= 0;
var y{e in E} >= 0;

/* Objective function 'z' */
minimize z: sum{e in E} (sum{seg in S} (m[e,seg]*a[seg] + u[e,seg]*b[seg]));

/* Constraints */
s.t. c1{d in D, v in V : v == s[d]} : sum{e in E} (A[e,v]*x[e,d] - B[e,v]*x[e,d]) == h[d];
s.t. c2{d in D, v in V : v <> s[d] and v <> t[d]} : sum{e in E} (A[e,v]*x[e,d] - B[e,v]*x[e,d]) == 0;
s.t. c3{d in D, v in V : v == t[d]} : sum{e in E} (A[e,v]*x[e,d] - B[e,v]*x[e,d]) == -h[d];
s.t. c4{e in E}: sum{d in D} x[e,d] = y[e];
s.t. c5{e in E}: sum{seg in S} m[e,seg] = y[e];
s.t. c6{e in E}: sum{seg in S} u[e,seg] = 1;
s.t. c7{e in E, seg in S}: m[e,seg] <= u[e,seg]*W;


printf{e in E, v in V} "A[%d,%d] = %d, B[%d,%d] = %d\n", e, v, A[e, v], e, v, B[e, v];
printf{d in D} "s[%d] = %d, t[%d] = %d, h[%d] = %d\n", d, s[d], d, t[d], d, h[d];

/* Input data */
data;

param V_count := 10;
param E_count := 16;
param D_count := 2;

param S_count := 2;

param :  a    b :=
 1       1    0
 2       0.33 0.66
;

param : h  s t :=
 1      3 1 10
 2      4 2 8
;

param : A :=
 1,1    1
 2,1    1
 3,2    1
 4,2    1
 5,2    1
 6,3    1
 7,3    1
 8,4    1
 9,5    1
 10,5   1
 11,6   1
 12,6   1
 13,7   1
 14,10  1
 15,7   1
 16,9   1
;  

param : B :=
 1,2    1
 2,3    1
 3,3    1
 4,5    1
 5,6    1
 6,6    1
 7,4    1
 8,6    1
 9,8    1
 10,7   1
 11,7   1
 12,9   1
 13,9   1
 14,8   1
 15,10  1
 16,10  1
;

end;
