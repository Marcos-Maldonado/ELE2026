%EJERCICIO 7
clear
clc
%Definicion de datos
r1=1;
r2=2;
r=10;
J1=1;
J2=0.5;
%Primer metodo de calculo, kirchof.
A=[r 1 0;r 0 -1;1 0 0]
B=[-J1*r1;J2*r2;J1-J2]
solucion1=inv(A)*B
% segunda solucion
C=[1/r1 -1/r1 0;-1/r1 1/r1+1/r+1/r2 -1/r2;0 -1/r2 1/r2]
D=[J1;0;-J2]
solucion2=inv(C)*D


