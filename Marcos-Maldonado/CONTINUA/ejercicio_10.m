%EJERCICIO 10
%DATOS
clear
clc

r12=1.5;
r23=1.5;
r13=2;
r20=10;
r10=0.1;
E=100;
J=0.1;

A=[1/r10+1/r12+1/r13 -1/r12 -1/r13;-1/r12 1/r12+1/r20+1/r23 -1/r23;-1/r13 -1/r23 1/r23+1/r13]
B=[E/r10;0;-J]
SOLUCION=inv(A)*B
V1=SOLUCION(1,1)
V2=SOLUCION(2,1)
V3=SOLUCION(3,1)

i10=(E-V1)/r10
i12=(V1-V2)/r12
i13=(V1-V3)/r13
i23=(V2-V3)/r23
i20=V2/r20

