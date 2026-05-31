clear
clc
%EJERCICIO 23
r12=r14=r25=r56=r45=1;
r15=r23=2;
r36=3;
r10=0.5;
r50=0.1;
E1=100;
E5=105;
J3=2;
%armado de G
G=[1/r12+1/r15+1/r14+1/r10 -1/r12 0 -1/r14 -1/r15 0;
-1/r12 1/r12+1/r23+1/r25 -1/r23 0 -1/r25 0;
0 -1/r23 1/r23+1/r36 0 0 -1/r36;
-1/r14 0 0 1/r14+1/r45 -1/r45 0;
-1/r15 -1/r25 0 -1/r45 1/r25+1/r15+1/r45+1/r50+1/r56 -1/r56;
0 0 -1/r36 0 -1/r56 1/r36+1/r56]
%ARMADO DE J
J=[E1/r10;0;-J3;0;E5/r50;0]
%CALCULO U th:
disp("LA Uth es:")
Uth=inv(G)*J

% Cantidad de nodos
n = size(G,1);

% =========================
% INVERSA DE G
% =========================

Ginv = inv(G);

% Vector donde guardaremos
% las resistencias equivalentes
Rth = zeros(n,1);

disp('==============================');
disp('CALCULO DE Rth POR INYECCION');
disp('==============================');

for k = 1:n

    % -------------------------
    % Construccion de J
    % -------------------------

    Jf = zeros(n,1);

    % Inyeccion de 1A
    Jf(k,1) = 1;

    % -------------------------
    % Calculo de tensiones
    % -------------------------

    U = Ginv * Jf;

    % -------------------------
    % Resistencia equivalente
    % -------------------------

    Rth(k) = U(k);

end
Rth
%Contruccion de Jn
Jn = zeros(n,1);
Pcc = zeros(n,1);
for m= 1:n
  Jn(m,1)=Uth(m,1)/Rth(m,1);
  Pcc(m,1)=Uth(m,1)*Jn(m,1);
end
disp("Las Jn (Corrientes de cortocircuito o norton son:")
Jn
disp("las potencias de cortocircuito son:")
Pcc



