clear
clc

%EJERCICIO 13
%DATOS
r1=2;
r2=2;
r3=4;
E1=10;
E2=8;
%METODO 1 (Kirchoff)
A=[r1 r2 0;0 r2 -r3;1 -1 -1]
B=[E1+E2;E2;0]
CORRIENTES=inv(A)*B
%METODO 2 (Potencial de nodos)
V2=(E1/r1-E2/r2)/(1/r1+1/r2+1/r3)
i1=(E1-V2)/r1
i2=(E2+V2)/r2
i3=V2/r3

