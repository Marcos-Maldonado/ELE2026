%EJERCICIO 48:
clear
clc
a = exp(1*i*2*pi/3);
ZL=[1+i 0.2i 0.2i;
0.2i 1+i 0.2i;
0.2i 0.2i 1+i];
U1_rst=[100;105*a^2;95*a];
I_rst=inv(ZL)*U1_rst
disp("SEGUNDO METODO (pno)")
A=[1 1 1;a^2 a 1;a a^2 1];
Z_pno=inv(A)*ZL*A
U_pno=inv(A)*U1_rst;
I_pno=inv(Z_pno)*U_pno;
I2_rst=A*I_pno
