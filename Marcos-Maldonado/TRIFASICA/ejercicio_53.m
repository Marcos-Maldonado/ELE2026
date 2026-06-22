%Ejercicio 53
clear
clc
c=100*10^(-6);
L=1*10^(-3);
w=314;
r=0.1;
Xc = 1/i*w*c;      % valor de Xc
Xl = r+i*w*L;       % valor de Xl
n  = 3;       % tamaño de la matriz nxn

% =========================
% MATRIZ NODAL DE LA LINEA
% =========================
n = N + 1;             % cantidad de nodos de la linea
G = zeros(n,n);

Yc = 1/Xc;
Yl = 1/Xl;

% diagonal
G(1,1) = Yc + Yl;
G(n,n) = Yc + Yl;

for i = 2:n-1
  G(i,i) = 2*Yc + 2*Yl;
endfor

% fuera de diagonal
for i = 1:n-1
  G(i,i+1) = -Yl;
  G(i+1,i) = -Yl;
endfor

disp("Matriz nodal G = ")
disp(G)

% =========================
% PARTICION DE LA MATRIZ
% Nodos externos: entrada y salida
% Nodos internos: todos los del medio
% =========================
ext = [1 n];
int = 2:n-1;

Gaa = G(ext,ext);
Gab = G(ext,int);
Gba = G(int,ext);
Gbb = G(int,int);

% =========================
% MATRIZ EQUIVALENTE
% =========================
Geq = Gaa - Gab * inv(Gbb) * Gba;

disp("Matriz equivalente Geq = ")
disp(Geq)

% =========================
% Zth vista desde la salida
% con la entrada anulada, V1 = 0
% =========================
Yth = Geq(2,2);
Zth = 1/Yth;

disp("Admitancia de Thevenin Yth = ")
disp(Yth)

disp("Impedancia de Thevenin Zth = ")
disp(Zth)

% G es tu matriz nodal completa
n = size(G,1);

Zth = zeros(n,1);

for k = 1:n
  J = zeros(n,1);
  J(k) = 1;          % inyecto 1 A en el nodo k

  U = inv(G)*J;      % tensiones nodales

  Zth(k) = U(k);     % como I = 1 A, Zth = U/I = U
endfor

disp("Zth de cada nodo a tierra = ")
disp(Zth)
