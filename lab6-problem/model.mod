# MPSiS 2018/2019
# Some optimization problem

param A_count, integer, >= 0;
param Count_constraint, integer, >= 0;

set A, default {1..A_count};
set B_set, default {1..Count_constraint};

/* Constraint parameters */
param C_constr{a in A, b in B_set}, integer, >= 0;

/* To nasze smieszne B */
param B{b in B_set}, integer, >= 0;

/* Parameters of goal function */
param C{a in A}, integer, >= 0;

/* Decision variables */
var x{a in A} >= 0;

/* Objective function 'z' */
minimize z: sum{a in A} C[a]*x[a];

/* Constraints */
s.t. c1{b in B_set}: sum{a in A} C_constr[a,b]*x[a] >= B[b];
s.t. c2: x[1] + 2*x[2] = B[2];

data;

param A_count := 3;
param Count_constraint := 2;

param : C_constr :=
 1,1    2
 1,2    1
 2,1    1
 2,2    2
 3,1    4
 3,2    0
;

param : B :=
 1      1
 2      1
;

param : C :=
 1      2
 2      2
 3      3
;

end;
