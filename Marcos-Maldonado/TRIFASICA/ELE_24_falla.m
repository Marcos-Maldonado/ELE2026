% =====================================================================
%  ELE_24 - Fallas asimetricas en coordenadas de fase
%  Resolucion por sistema unificado 6x6 (condiciones de borde)
%
%      [ I3   Zth ] [ U ]   [ Eth ]
%      [ A    B   ] [ I ] = [  0  ]
%
%  Las 3 filas de arriba son SIEMPRE la red (U + Zth*I = Eth).
%  Las 3 filas de abajo [A|B] caracterizan el tipo de falla.
%
%  Octave / MATLAB.  Autor: Mag. Ing. R. Rodrigo - FI UNSJ
% =====================================================================

clear; clc;

% ---------- Datos de la red (equivalente de Thevenin) ----------------
a   = exp(1j*2*pi/3);          % operador de rotacion 1 /_ 120
E   = 1.0;                     % tension de fase (p.u.)
%Eth = E*[1; a^2; a];           % fuente de circuito abierto (sec. positiva)
Eth= [108.644-2.362*i;
       -56.368-92.908*i;
       -52.277+95.270*i];

Zth = [1.2625+5.5737i 0.0816+1.2515i 0.0816+1.2515i;         % impedancia de Thevenin (3x3, puede ser llena)
         0.0816+1.2515i 1.2625+5.5737i 0.0816+1.2515i;
         0.0816+1.2515i 0.0816+1.2515i 1.2625+5.5737i];

% ---------- Seleccion de la falla ------------------------------------
%   '3FT'    : trifasica a tierra
%   '1FT_a'  : monofasica a tierra, fase a
%   '2FT_bc' : bifasica a tierra, fases b-c
%   '2F_bc'  : bifasica aislada, fases b-c
%   '3F'     : trifasica aislada
tipo = '1FT_a';
Zf   = 0.0;                    % impedancia de falla por fase
rt   = 0.0;                    % resistencia de puesta a tierra

% ---------- Resolucion -----------------------------------------------
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
