%EJERCICIO 49
clear
clc
a = exp(1*i*2*pi/3);
Z=[1+i 0.2i 0.2i;
0.2i 1+i 0.2i;
0.2i 0.2i 1+i];
E_rst = 100*[1; a^2; a];
J2=[5;8*a^2;3*a];
J3=[10;15*a^2;5*a];
%POTENCIALES DE NODOS
disp("POR EL METODO DE POTENCIALES DE NODOS")
N=[inv(Z)+inv(Z)+inv(Z) -inv(Z) -inv(Z);
-inv(Z) inv(Z) zeros(3,3);
-inv(Z) zeros(3,3) inv(Z)];
J=[inv(Z)*E_rst;-J2;-J3];
U_rst=inv(N)*J;
U1=U_rst(1:3)
U2=U_rst(4:6)
U3=U_rst(7:9)
%POR KIRCHOF
disp("POR KIRCHOFF")
U11=E_rst-Z*(J2+J3)
U22=U1-Z*J2
U33=U1-Z*J3
%POR pno
disp("POR EL METODO DE DIAGONALIZACION pno")
A=[1 1 1;a^2 a 1;a a^2 1];
Z_pno=inv(A)*Z*A;
E_pno=inv(A)*E_rst;
J2_pno=inv(A)*J2;
J3_pno=inv(A)*J3;
N_pno=[inv(Z_pno)+inv(Z_pno)+inv(Z_pno) -inv(Z_pno) -inv(Z_pno);
-inv(Z_pno) inv(Z_pno) zeros(3,3);
-inv(Z_pno) zeros(3,3) inv(Z_pno)];
J_pno=[inv(Z_pno)*E_pno;-J2_pno;-J3_pno];
U_pno=inv(N_pno)*J_pno;
U111=A*U_pno(1:3)
U222=A*U_pno(4:6)
U333=A*U_pno(7:9)


