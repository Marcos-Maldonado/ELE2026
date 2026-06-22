%EJERCICIO 52
clear
clc
a = exp(1*i*2*pi/3);
%DATOS
Eth= [108.644-2.362*i;
       -56.368-92.908*i;
       -52.277+95.270*i];
Zth = [1.2625+5.5737i 0.0816+1.2515i 0.0816+1.2515i;         % impedancia de Thevenin (3x3, puede ser llena)
         0.0816+1.2515i 1.2625+5.5737i 0.0816+1.2515i;
         0.0816+1.2515i 0.0816+1.2515i 1.2625+5.5737i];
disp("FALLO BIPOLAR AISLADO")
FALLO=[0 -1 1 0 0 0;
0 0 0 0 1 1;
0 0 0 1 0 0];
A=[eye(3) Zth;FALLO]
B=[Eth;0;0;0]
disp("Ur;Us;Ut;Ir;Is;It")
X=inv(A)*B


%POR ALGORITMO AUTOMATICO:
tipo = '2F_bc';
Zf   = 0.0;                    % impedancia de falla por fase
rt   = 0.0;
[If, Uf, M] = resolver_falla(Eth, Zth, tipo, Zf, rt);
disp('--- Matriz M del sistema ---')
disp(M)

disp('--- Tensiones en el punto de falla Uf = [Ua; Ub; Uc] ---')
disp(Uf)

disp('--- Corrientes de falla If = [Ia; Ib; Ic] ---')
disp(If)

disp('--- Modulo de Uf ---')
disp(abs(Uf))

disp('--- Angulo de Uf en grados ---')
disp(angle(Uf)*180/pi)

disp('--- Modulo de If ---')
disp(abs(If))

disp('--- Angulo de If en grados ---')
disp(angle(If)*180/pi)
