%Ejercicio 43
clear
clc

a = exp(1*i*2*pi/3);

E_rst = 100*[1; a^2; a];

J2 = 5*exp(-1*i*30*pi/180)*[1; a^2; a];
J3 = 8*exp(-1*i*20*pi/180)*[1; a^2; a];

Zg = [0.1*i 0 0;
      0 0.1*i 0;
      0 0 0.1*i];

Z1 = [0.1+0.3*i 0.2*i 0.2*i;
      0.2*i 0.1+0.3*i 0.2*i;
      0.2*i 0.2*i 0.1+0.3*i];

Yg = inv(Zg);
Y1 = inv(Z1);
Y15 = inv(1.5*Z1);

N = [Yg+Y1,   -Y1,       zeros(3,3);
     -Y1,     Y1+Y15,   -Y15;
     zeros(3,3), -Y15,   Y15];
Jnodal=[Yg*E_rst;-J2;-J3];

Unodal=inv(N)*Jnodal

U1=Unodal(1:3)
U2=Unodal(4:6)
U3=Unodal(7:9)
disp("verificacion")
X1=U2-U3
X11=1.5*Z1*J3
X2=U1-U2
X22=Z1*(J3+J2)
