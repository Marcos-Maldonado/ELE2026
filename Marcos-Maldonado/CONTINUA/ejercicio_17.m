clear
clc
%EJERCICIO 17
%DATOS
r1=r2=1;
r3=r4=1.2;
R1=R2=10;
R3=R4=R5=15;
%Armado de matrices
G11=[1/r1+1/R1 0;0 1/r4+1/R5];
G12=[-1/r1 0 0;0 0 -1/r4];
G21=[-1/r1 0;0 0;0 -1/r4];
G22=[1/r1+1/r2+1/R2 -1/r2 0;-1/r2 1/r2+1/r3+1/R3 -1/r3;0 -1/r3 1/r3+1/r4+1/R4];
disp("LA MATRIZ EQUIVALENTE ES:")
Geq=G11-G12*inv(G22)*G21
disp("LOS VALORES DE RESISTENCIAS EQUIVALENTES SON:")
r1eq=-1/Geq(1,2)
R1eq=1/(Geq(1,1)-1/r1eq)
R2eq=1/(Geq(2,2)-1/r1eq)
disp("VERIFICACION:")
J1=1
J2=1
A=[G11 G12;G21 G22]
B=[J1;J2;0;0;0]
Potenciales=inv(A)*B
Geq
C=[J1;J2]
PotencialesEq=inv(Geq)*C

