%ELECTROTECNIA 2 - ARMADO AUTOMATICO DE MATRIZ NODAL TRIFASICA
%Este archivo es un SCRIPT, no una funcion.
%Vos solo modificas la zona de DATOS DEL CIRCUITO.
%
%Convencion:
%   N * V = Jnodal
%   ref = nodo de referencia, normalmente 0 o 1 segun tu circuito.
%   Cada nodo trifasico tiene 3 incognitas: fase r, fase s, fase t.
%
%--------------------------------------------------------------------------
clear
clc
format short g

%==========================
% DATOS DEL CIRCUITO
%==========================

nph = 3;        % cantidad de fases
ref = 0;        % nodo de referencia / tierra

% Operador trifasico
a = exp(1i*2*pi/3);

%--------------------------
% Impedancias de ejemplo
% Cambialas por las tuyas
%--------------------------
Zg=[3i 0 0;
0 3i 0;
0 0 3i];

Zl=[1+2i 1i 1i;
1i 1+2i 1i;
1i 1i 1+2i];

Zc=[1-50i 1 1;
1 1-50i 1;
1 1 1-50i];

%--------------------------
% Fuentes de tension con impedancia serie
% Formato:
% fuentesE = {
%    nodo, Zserie, E_fasorial_3x1;
% };
% La fuente se transforma internamente a Norton:
%    Yg = inv(Zg)
%    Jg = Yg * E
%--------------------------
E_rst=100*[1;a^2;a];

fuentesE = {
    1, Zg, E_rst
};

%--------------------------
% Ramas entre nodos
% Formato:
% ramas = {
%    nodo_i, nodo_j, Zij;
% };
% Puede haber varias ramas entre los mismos nodos.
% Si una rama va a tierra, usa el nodo ref.
%--------------------------
ramas = {
    1, 2, Zl;
    1, 0, Zg;
    2, 0, Zc};

%--------------------------
% Fuentes de corriente / cargas
% Formato:
% fuentesJ = {
%    nodo, J_fasorial_3x1, signo;
% };
%
% signo = +1  corriente entra al nodo, inyeccion
% signo = -1  corriente sale del nodo, carga
%--------------------------
%J2=[5;8*a^2;3*a]
J2=[0;0*a^2;0*a]
%J3=[10;15*a^2;5*a]

%fuentesJ = {
 %   2, J2, -1;
  %  3, J3, -1};
fuentesJ = {
    2, J2, -1};

%=========================================================================
% DESDE ACA ABAJO NO TOCAR
%=========================================================================

%--------------------------
% Detectar nodos automaticamente
%--------------------------
nodos = [];

if exist('ramas','var') && !isempty(ramas)
    nodos = [nodos; cell2mat(ramas(:,1)); cell2mat(ramas(:,2))];
endif

if exist('fuentesE','var') && !isempty(fuentesE)
    nodos = [nodos; cell2mat(fuentesE(:,1))];
endif

if exist('fuentesJ','var') && !isempty(fuentesJ)
    nodos = [nodos; cell2mat(fuentesJ(:,1))];
endif

nodos = unique(nodos);
nodos(nodos == ref) = [];        % se elimina la referencia de las incognitas
nodos = nodos(:);

nn = length(nodos);
N = zeros(nph*nn, nph*nn);
Jnodal = zeros(nph*nn, 1);

%--------------------------
% Funcion local para ubicar el bloque de cada nodo
% En scripts de Octave modernos se permiten funciones locales al final,
% pero para mayor compatibilidad uso busqueda directa con find.
%--------------------------

%--------------------------
% Sellado de ramas pasivas
%--------------------------
for k = 1:rows(ramas)
    ni = ramas{k,1};
    nj = ramas{k,2};
    Z  = ramas{k,3};
    Y  = inv(Z);

    idx_i = [];
    idx_j = [];

    if ni != ref
        pi = find(nodos == ni);
        idx_i = (nph*(pi-1)+1):(nph*pi);
    endif

    if nj != ref
        pj = find(nodos == nj);
        idx_j = (nph*(pj-1)+1):(nph*pj);
    endif

    if !isempty(idx_i)
        N(idx_i, idx_i) = N(idx_i, idx_i) + Y;
    endif

    if !isempty(idx_j)
        N(idx_j, idx_j) = N(idx_j, idx_j) + Y;
    endif

    if !isempty(idx_i) && !isempty(idx_j)
        N(idx_i, idx_j) = N(idx_i, idx_j) - Y;
        N(idx_j, idx_i) = N(idx_j, idx_i) - Y;
    endif
endfor

%--------------------------
% Sellado de fuentes de tension con Z serie
% Equivalente Norton: J = inv(Zg)*E
%--------------------------
for k = 1:rows(fuentesE)
    n  = fuentesE{k,1};
    Zs = fuentesE{k,2};
    E  = fuentesE{k,3};
    Ys = inv(Zs);
    Jn = Ys * E;

    if n != ref
        p = find(nodos == n);
        idx = (nph*(p-1)+1):(nph*p);
        N(idx, idx) = N(idx, idx) + Ys;
        Jnodal(idx) = Jnodal(idx) + Jn;
    endif
endfor

%--------------------------
% Sellado de fuentes de corriente / cargas
%--------------------------
for k = 1:rows(fuentesJ)
    n     = fuentesJ{k,1};
    J     = fuentesJ{k,2};
    signo = fuentesJ{k,3};

    if n != ref
        p = find(nodos == n);
        idx = (nph*(p-1)+1):(nph*p);
        Jnodal(idx) = Jnodal(idx) + signo*J;
    endif
endfor

%--------------------------
% Resolver tensiones nodales
%--------------------------
V = N \ Jnodal;

%--------------------------
% Mostrar resultados
%--------------------------
disp('Nodos detectados como incognitas:')
disp(nodos.')

disp('Matriz nodal N:')
disp(N)

disp('Vector Jnodal:')
disp(Jnodal)

disp('Tensiones nodales V = N\\Jnodal:')
disp(V)

% Tabla util: cada fila es un nodo y columnas son fases r,s,t
Vnodos = reshape(V, nph, nn).';
disp('Tensiones por nodo [Vr; Vs; Vt]:(recordar que la U1 es la primer Fila, U2 la segunda...)')
disp(Vnodos)
