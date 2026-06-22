%EJERCICIO 53
clear
clc

a = exp(1*i*2*pi/3);

%DATOS
C = 100*10^(-6);
L = 1*10^(-3);
R = 0.1;
n = 4;        % numero de nodos
w = 314;
E = 100*[1; a^2; a];
Zg = [1i 0 0;
      0 1i 0;
      0 0 1i];
Xlr = R + L*w*i;
Xl  = L*w*i;
Xc  = 1/(w*C*i);

% MATRICES DE IMPEDANCIAS
Zl = [Xlr Xl  Xl;
      Xl  Xlr Xl;
      Xl  Xl  Xlr];

Zc = [Xc 0  0;
      0  Xc 0;
      0  0  Xc];

Yl = inv(Zl);
Yc = inv(Zc);

% MATRIZ NODAL TRIFASICA
N = zeros(3*n,3*n);

% Diagonal principal por bloques 3x3
for k = 1:n

    idx = 3*(k-1)+1 : 3*k;

    if (k == 1 || k == n)
        N(idx,idx) = Yl + Yc;
    else
        N(idx,idx) = 2*Yl + 2*Yc;
    endif
endfor

% Diagonales laterales por bloques 3x3
for k = 1:n-1
    idx_k  = 3*(k-1)+1 : 3*k;
    idx_k1 = 3*k+1 : 3*(k+1);

    N(idx_k,idx_k1) = -Yl;
    N(idx_k1,idx_k) = -Yl;
endfor
J1=[inv(Zg)*E;0;0;0;0;0;0;0;0;0];
U_sinreducir=inv(N)*J1;
disp("EQUIVALENTE Zth por el metodo de reduccion de SCHUR en el nodo 1")
N11 = N(1:3,1:3);
N12 = N(1:3,4:end);
N21 = N(4:end,1:3);
N22 = N(4:end,4:end);
Yeq1 = N11 - N12*(N22\N21);
Zth_schur_1 = inv(Yeq1)

%SEGUNDO METODO, INYECCION DE CORRIENTES EN NODOS

disp("EQUIVALENTE Zth por el metodo de inyeccion de corrientes de prueba en los nodos")
cantidad_nodos = 4;
fases = 3;

Zth1 = zeros(3,3);
Zth2 = zeros(3,3);
Zth3 = zeros(3,3);
Zth4 = zeros(3,3);

Zth = zeros(3,3,cantidad_nodos);

for nodo = 1:cantidad_nodos

  nodos_salida = (nodo-1)*fases + (1:fases);

  for k = 1:fases
    Jprueba = zeros(size(N,1),1);
    Jprueba(nodos_salida(k)) = 1;

    Uprueba = inv(N)*Jprueba;

    Zth(:,k,nodo) = Uprueba(nodos_salida);
  end

end

Zth1 = Zth(:,:,1);
Zth2 = Zth(:,:,2);
Zth3 = Zth(:,:,3);
Zth4 = Zth(:,:,4);

disp("Zth del nodo 1:")
Zth1

disp("Zth del nodo 2:")
Zth2

disp("Zth del nodo 3:")
Zth3

disp("Zth del nodo 4:")
Zth4

%CIRCUITO EQUIVALENTE POR EL METODO DE ELIMINACION DE NODOS DE SHUSCHUR
disp("circuito equivalente por el metodo de eliminacion de nodos de SCHUR")

%% =====================================================
%% PI EQUIVALENTE EXACTO DE 2 NODOS POR SCHUR
%% Conserva nodo 1 y nodo 4
%% Elimina nodos 2 y 3
%% =====================================================

disp("==============================================")
disp("PI EQUIVALENTE EXACTO DE 2 NODOS POR SCHUR")
disp("==============================================")

% Nodos externos: nodo 1 y nodo 4
idx_ext = [1:3 10:12];

% Nodos internos: nodo 2 y nodo 3
idx_int = 4:9;

Naa = N(idx_ext,idx_ext);
Nab = N(idx_ext,idx_int);
Nba = N(idx_int,idx_ext);
Nbb = N(idx_int,idx_int);

% Matriz nodal equivalente 6x6
Neq_pi = Naa - Nab*(Nbb\Nba);

disp("Matriz nodal equivalente Neq_pi:")
Neq_pi

% Bloques 3x3
N11_pi = Neq_pi(1:3,1:3);
N12_pi = Neq_pi(1:3,4:6);
N21_pi = Neq_pi(4:6,1:3);
N22_pi = Neq_pi(4:6,4:6);

% En un circuito PI:
%
% Neq = [Yt1 + Ym    -Ym
%        -Ym         Yt2 + Ym]
%
% Ym  = admitancia de la rama del medio
% Yt1 = admitancia a tierra lado 1
% Yt2 = admitancia a tierra lado 2

Ym_eq = -N12_pi;

Yt1_eq = N11_pi - Ym_eq;
Yt2_eq = N22_pi - Ym_eq;

% Impedancias equivalentes 3x3
Zm_eq  = inv(Ym_eq);    % impedancia del medio
Zt1_eq = inv(Yt1_eq);   % impedancia puesta a tierra lado 1
Zt2_eq = inv(Yt2_eq);   % impedancia puesta a tierra lado 2

disp("Impedancia del medio del PI equivalente Zm_eq:")
Zm_eq

disp("Impedancia de puesta a tierra lado 1 Zt1_eq:")
Zt1_eq

disp("Impedancia de puesta a tierra lado 2 Zt2_eq:")
Zt2_eq
%VERIFICACION, U DEL PRIMER METODO ESTA CALCULADA MAS ARRIBA
disp("con la fuente conectada los potenciales sin reducir son:")
U_sinreducir
disp("con la fuente conectada los potenciales del circuito reducido son:")
J2=[inv(Zg)*E;0;0;0];
U_reducido=inv(Neq_pi)*J2


