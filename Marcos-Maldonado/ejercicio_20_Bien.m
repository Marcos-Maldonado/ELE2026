clear
clc
close all

%EJERCICIO 20 (CALCULO DE LAS FUENTES PARA TENER EL POTENCIAL CORRECTO EN CADA NODO)

%DATOS
r12=r36=r56=r45=r14=1;
r23=3;
r25=r15=2;
r10=r60=0.5;
J4=J3=J5=1;

%ARMADO DE LA MATRIZ NODAL
G=[ 1/r10+1/r14+1/r12+1/r15   -1/r12                     0        -1/r14          -1/r15                0;
   -1/r12                     1/r12+1/r23+1/r25         -1/r23     0               -1/r25                0;
    0                        -1/r23                      1/r23+1/r36 0               0                    -1/r36;
   -1/r14                     0                          0          1/r14+1/r45     -1/r45                0;
   -1/r15                    -1/r25                      0         -1/r45           1/r25+1/r15+1/r45+1/r56   -1/r56;
    0                         0                         -1/r36      0               -1/r56                1/r56+1/r36+1/r60 ];

%VECTORES BASE
% OJO: b1 y b2 NO llevan E1 ni E2 adentro
b1=[1/r10; 0; 0; 0; 0; 0];
b2=[0; 0; 0; 0; 0; 1/r60];
b0=[0; 0; -J3; -J4; -J5; 0];

%CALCULO DE LOS VECTORES a, c, d
a=G\b1;
c=G\b2;
d=G\b0;

disp('Vector a = G^{-1} b1')
disp(a)

disp('Vector c = G^{-1} b2')
disp(c)

disp('Vector d = G^{-1} b0')
disp(d)

%EXPRESION GENERAL DE LOS POTENCIALES NODALES
% U = E1*a + E2*c + d

%PRUEBA CON UN PAR DE VALORES
E1_test=109;
E2_test=92.5;
U_test=E1_test*a + E2_test*c + d;

disp('Potenciales nodales para E1=100 V, E2=100 V')
disp(U_test)

if all(U_test>=95 & U_test<=105)
    disp('El punto () ES factible')
else
    disp('El punto () NO es factible')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGION FACTIBLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RANGO DE BUSQUEDA
E1_vals=90:0.05:112;
E2_vals=90:0.05:112;

Ef1=[];
Ef2=[];

for E1=E1_vals
    for E2=E2_vals
        U=E1*a + E2*c + d;

        if all(U>=95 & U<=105)
            Ef1(end+1)=E1;
            Ef2(end+1)=E2;
        end
    end
end

%GRAFICO DE PUNTOS FACTIBLES
figure
plot(Ef1,Ef2,'b.','markersize',8)
grid on
xlabel('E1 [V]')
ylabel('E2 [V]')
title('Region factible de (E1,E2)')
axis equal

hold on
plot(E1_test,E2_test,'ro','markersize',10,'linewidth',2)

%SI HAY PUNTOS FACTIBLES, DIBUJO EL CONTORNO
if ~isempty(Ef1)
    K=convhull(Ef1,Ef2);
    plot(Ef1(K),Ef2(K),'r-','linewidth',2)
    legend('Puntos factibles','Punto de prueba','Contorno')
else
    legend('Punto de prueba')
    disp('No se encontraron puntos factibles en el rango buscado')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOSTRAR LAS INECUACIONES EN FORMA NUMERICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('----------------------------------------------')
disp('Inecuaciones nodales:')
for i=1:6
    fprintf('Nodo %d: 95 <= %.6f*E1 + %.6f*E2 + %.6f <= 105\n', i, a(i), c(i), d(i));
end
disp('----------------------------------------------')
