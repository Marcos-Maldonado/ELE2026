clear
clc
%EJERCICIO 11
%DATOS
re=1;
r12=1;
r13=5;
r10=12;
r20=6;
r23=10;
r30=1;
E=10;
%MATRIZ NODAL
A=[1/re+1/r12+1/r13+1/r10 -1/r12 -1/r13;-1/r12 1/r12+1/r20+1/r23 -1/r23;-1/r13 -1/r23 1/r13+1/r23+1/r30]
B=[E/re;0;0]
SOLUCION=inv(A)*B
V1=SOLUCION(1,1);
V2=SOLUCION(2,1);
V3=SOLUCION(3,1);
%CALCULO DE CORRIENTES
i12=(V1-V2)/r12
i13=(V1-V3)/r13
i10=V1/r10
ie=(E-V1)/re
i23=(V2-V3)/r23
i20=V2/r20
i30=V3/r30

