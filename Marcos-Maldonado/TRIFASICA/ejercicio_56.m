%EJERCICIO 56
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

A=[1 1 1;
a^2 a 1;
a a^2 1];

E_pno=inv(A)*Eg;
J3_pno=inv(A)*J3;
J4_pno=inv(A)*J4;
Zl_pno=inv(A)*Zl*A;
Zg_pno=inv(A)*Zg*A;

%DATOS EN PNO
Ep=E_pno(1,1);
J3_p=J3_pno(1,1);
J4_p=J4_pno(1,1);
Zg_p=Zg_pno(1,1);
Zl_p=Zl_pno(1,1);

Z12_p=Zl_p;
Z23_p=2*Zl_p;
Z24_p=1.5*Zl_p;
Z34_p=5*Zl_p;

N_p=[inv(Zg_p)+inv(Z12_p) -inv(Z12_p) 0 0;
-inv(Z12_p) inv(Z12_p)+inv(Z24_p)+inv(Z23_p) -inv(Z23_p) -inv(Z24_p);
0 -inv(Z23_p) inv(Z23_p)+inv(Z34_p) -inv(Z34_p);
0 -inv(Z24_p) -inv(Z34_p) inv(Z24_p)+inv(Z34_p)];

J_nodal_p=[inv(Zg_p)*Ep;0;-J3_p;-J4_p];
U_nodal_p=inv(N_p)*J_nodal_p

disp("POTENCIALES EN PNO")
U_nodal_p

% Reconstrucción trifásica desde secuencia positiva
Ua = U_nodal_p;
Ub = a^2 * U_nodal_p;
Uc = a * U_nodal_p;

U_rst = [Ua Ub Uc];

disp("POTENCIALES REALES RST / ABC")
U_rst
disp("las CORRIENTES")


% Corriente rama 24 calculada desde secuencia positiva
I24_p = (U_nodal_p(2,1)-U_nodal_p(4,1))/Z24_p;

I24_p_rst = I24_p*[1; a^2; a]

% Corriente rama 24 calculada directamente en RST
U24_rst = (U_rst(2,:) - U_rst(4,:)).';

I24_rst = inv(Z24)*U24_rst
% En módulo y ángulo
disp("MODULOS DE LOS POTENCIALES")
abs(U_rst)

disp("ANGULOS EN GRADOS DE LOS POTENCIALES")
angle(U_rst)*180/pi

