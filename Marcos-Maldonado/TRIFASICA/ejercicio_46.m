%EJERCICIO 46
clear
clc
a = exp(1*i*2*pi/3);
E_rst = 100*[1; a^2; a];

Zl = [0.1+0.3*i 0.2*i 0.2*i;
      0.2*i 0.1+0.3*i 0.2*i;
      0.2*i 0.2*i 0.1+0.3*i];

J2 = 5*exp(-1*i*30*pi/180)*[1; a^2; a];
J3 = 8*exp(-1*i*20*pi/180)*[1; a^2; a];

N=[inv(Zl)+inv(Zl*1.5)+inv(Zl*1.8) -inv(Zl*1.5) -inv(Zl*1.8);-inv(Zl*1.5) inv(Zl*1.5) zeros(3,3);-inv(Zl*1.8) zeros(3,3) inv(Zl*1.8)];
J_nodal=[inv(Zl)*E_rst;-J2;-J3];
U_rst=inv(N)*J_nodal;
U1_rst=U_rst(1:3)
U2_rst=U_rst(4:6)
U3_rst=U_rst(7:9)

disp("VERIFICACION")
X1=U1_rst-U2_rst
X11=1.5*Zl*J2
X2=U1_rst-U3_rst
X22=1.8*Zl*J3
