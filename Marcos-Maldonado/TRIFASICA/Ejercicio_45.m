%EJERCICIO 45
clear
clc
a = exp(1*i*2*pi/3);
E_rst = 100*[1; a^2; a];

Zg = [0.1*i 0 0;
      0 0.1*i 0;
      0 0 0.1*i];

Zl = [0.1+0.3*i 0.2*i 0.2*i;
      0.2*i 0.1+0.3*i 0.2*i;
      0.2*i 0.2*i 0.1+0.3*i];

J2 = 5*exp(-1*i*30*pi/180)*[1; a^2; a];
J3 = 8*exp(-1*i*20*pi/180)*[1; a^2; a];

Yg = inv(Zg);
Y1 = inv(Zl);
Y15 = inv(1.5*Zl);

N = [Yg+Y1,   -Y1,       zeros(3,3);
     -Y1,     Y1+Y15,   -Y15;
     zeros(3,3), -Y15,   Y15];
Jnodal=[Yg*E_rst;-J2;-J3];

Unodal=inv(N)*Jnodal;
disp("Potencial en los nodos, equivalentes al Uth")
U1=Unodal(1:3)
U2=Unodal(4:6)
U3=Unodal(7:9)

disp("Zth es:")
Zth_3=Zg+Zl+Zl*1.5

%SEGUNDO METODO GENERAL
disp("segundo metodo general")

cantidad_nodos = 3;
fases = 3;

Zth1 = zeros(3,3);
Zth2 = zeros(3,3);
Zth3 = zeros(3,3);

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

disp("Zth del nodo 1:")
Zth1

disp("Zth del nodo 2:")
Zth2

disp("Zth del nodo 3:")
Zth3
