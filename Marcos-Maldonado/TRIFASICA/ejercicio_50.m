%EJERCICIO 50
clear
clc
a = exp(1*i*2*pi/3);
%DATOS
Zg=[3i 0 0;
0 3i 0;
0 0 3i];
Zl=[1+2i 1i 1i;
1i 1+2i 1i;
1i 1i 1+2i];
Zc=[1-50i 1 1;
1 1-50i 1;
1 1 1-50i];
E=100*[1; a^2; a];
%ARMADO DE LA MATRIX NODAL
N=[inv(Zg)+inv(Zl) -inv(Zl);
-inv(Zl) inv(Zl)+inv(Zc)];
J=[inv(Zg)*E;zeros(3,1)];
disp("Calculo del Uth, por el metodo de Potencial de NODOS")
U=inv(N)*J;
U1=U(1:3)
U2=U(4:6)
disp("Calculo de Zth por asociacion de Z")
Zaux=Zl+Zg;
Zth22=inv(inv(Zc)+inv(Zaux))

%FORMA POR INYECCION PARA CALCULAR Zth
disp("Calculo de Zth por inyeccion de 1A por nodo")

cantidad_nodos = 2;
fases = 3;

Zth1 = zeros(3,3);
Zth2 = zeros(3,3);

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

disp("Zth del nodo 1:")
Zth1

disp("Zth del nodo 2:")
Zth2


