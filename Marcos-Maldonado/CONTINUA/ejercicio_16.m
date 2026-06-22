clear
clc
%EJERCICIO 16
e1=10;
e2=12;
r1=1;
r2=1.5;
r=10;
A=[r1+r r;r r2+r]
B=[e1;e2]
solucion=inv(A)*B
i1=solucion(1,1)
i2=solucion(2,1)
i=i1+i2
