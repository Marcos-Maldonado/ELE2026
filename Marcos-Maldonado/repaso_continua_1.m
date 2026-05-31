clear
clc
%EJERCICIO REPASO 1
r=0.0000000000000001
A=[1/r+1+1/2 -1 -1/2;-1 1+1/2+1/10 -1/2;-1/2 -1/2 1/r+1/2+1/2]
B=[10/r;0;12/r]
solucion=inv(A)*B
