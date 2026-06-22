%EJERCICIO 55
clear
clc
a = exp(1*i*2*pi/3);
Eg = 100*[1; a^2; a];
J3 = 10*[1; a^2; a];
J4 = 5*[1; a^2; a];
Zl=[0.1+0.5i 0.2i 0.2i;
0.2i 0.1+0.5i 0.2i;
0.2i 0.2i 0.1+0.5i];

Zg=[1.5i 0 0;
0 1.5i 0;
0 0 1.5i];

Z12=Zl;
Z23=2*Zl;
Z24=1.5*Zl;
Z34=5*Zl;

N=[inv(Zg)+inv(Z12) -inv(Z12) zeros(3,3) zeros(3,3);
-inv(Z12) inv(Z12)+inv(Z24)+inv(Z23) -inv(Z23) -inv(Z24);
zeros(3,3) -inv(Z23) inv(Z23)+inv(Z34) -inv(Z34);
zeros(3,3) -inv(Z24) -inv(Z34) inv(Z24)+inv(Z34)];

J_nodal=[inv(Zg)*Eg;zeros(3,1);-J3;-J4];

U_nodal=inv(N)*J_nodal;
disp("POTENCIALES")
U1_rst=U_nodal(1:3)
U2_rst=U_nodal(4:6)
U3_rst=U_nodal(7:9)
U4_rst=U_nodal(10:12)
disp("CORRIENTES")


