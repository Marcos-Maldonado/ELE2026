%EJERCICIO 51
clear
clc
a = exp(1*i*2*pi/3);
%DATOS
Zg=[3i 0 0;
0 3i 0;
0 0 3i];
Zl=[1+2i 1i 1i;
1i 1+2i 1i;
1i 1i 1+2i];
Zc=[1-50i 1 1;
1 1-50i 1;
1 1 1-50i];
E=100*[1; a^2; a];
%ARMADO DE LA MATRIX NODAL
N=[inv(Zg)+inv(Zl) -inv(Zl);
-inv(Zl) inv(Zl)+inv(Zc)];
J=[inv(Zg)*E;zeros(3,1)];
disp("Calculo del Uth, por el metodo de Potencial de NODOS")
U=inv(N)*J;
U1=U(1:3);
Uth=U(4:6)
disp("Calculo de Zth por asociacion de Z")
Zaux=Zl+Zg;
Zth22=inv(inv(Zc)+inv(Zaux))
%ESTUDIO DEL FALLO UNIPOLAR
disp("FALL UNIPOLAR A TIERRA")
FALLO=[1 0 0 0 0 0;
0 0 0 0 1 0;
0 0 0 0 0 1];
A=[eye(3) Zth22;FALLO]
B=[Uth;0;0;0]
disp("Ur;Us;Ut;Ir;Is;It")
X=inv(A)*B


