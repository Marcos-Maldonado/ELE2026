%ejercicio 39
clear
clc
R=0.1;
L=0.002;
M=0.0005;
Z1=Z2=Z3=100+30*i;
w=314;
a=exp(1*i*2/3*pi);
%defino las matrices
E_rst=220*[1;a^2;a];
Zl_rst=[R+i*w*L i*w*M i*w*M;
i*w*M R+i*w*L i*w*M;
i*w*M i*w*M R+i*w*L];
Zc_rst=[Z1 0 0;0 Z2 0;0 0 Z3];
%CALCULO
I=inv(Zl_rst+Zc_rst)*E_rst
abs(I)
angle(I)*180/pi
%POR NODOS
disp("por nodos")
U_rst=inv(inv(Zl_rst)+inv(Zc_rst))*inv(Zl_rst)*E_rst;
I_rst=inv(Zc_rst)*U_rst
abs(I_rst)
angle(I_rst)*180/pi

