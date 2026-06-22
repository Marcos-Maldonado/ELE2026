%EXPLICACION DE CLASE
clear
clc
%A=[6 -4 4;3 -1 4;3 -3 6]
%h=[12;18;12]
%[P,D]=eig(A)
%h_=inv(P)*h
%A_=inv(P)*A*P %esta esta diagonalizada. pero hay error de redondeo por eso las diagonales no principales son cercanas a 0 pero no son 0.
disp("segundo ejemplo")
Zl=[1+i 0.2*i 0.2*i;0.2*i 1+i 0.2*i;0.2*i 0.2*i 1+i]
a = exp(1*i*2*pi/3);
A=[1 1 1;a^2 a 1;a a^2 1]
aux=[1 a a^2;1 a^2 a;1 1 1]
Ai=1/3*aux
X=A*Ai%deveria ser igual a la identidad
Zlprima=inv(A)*Zl*A
%Este metodo solo diagonaliza si la matriz tiene la matriz diagonal toda igual y el resto de valores todos iguales tamboien
disp("tercer ejemplo")
U1_rst=[100;105*a^2;95*a]
U2_rst=[0;0;0]
I_rst=inv(Zl)*U1_rst


