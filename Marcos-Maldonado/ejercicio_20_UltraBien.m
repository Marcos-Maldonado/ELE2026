clear
clc
close all

%EJERCICIO 20

%DATOS
r12=r36=r56=r45=r14=1;
r23=3;
r25=r15=2;
r10=r60=0.5;
J4=J3=J5=1;

%PUNTO DE PRUEBA (MODIFICABLE)
E1_test = 100;
E2_test = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATRIZ NODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G=[ 1/r10+1/r14+1/r12+1/r15   -1/r12                     0        -1/r14          -1/r15                0;
   -1/r12                     1/r12+1/r23+1/r25         -1/r23     0               -1/r25                0;
    0                        -1/r23                      1/r23+1/r36 0               0                    -1/r36;
   -1/r14                     0                          0          1/r14+1/r45     -1/r45                0;
   -1/r15                    -1/r25                      0         -1/r45           1/r25+1/r15+1/r45+1/r56   -1/r56;
    0                         0                         -1/r36      0               -1/r56                1/r56+1/r36+1/r60 ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VECTORES BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b1=[1/r10; 0; 0; 0; 0; 0];
b2=[0; 0; 0; 0; 0; 1/r60];
b0=[0; 0; -J3; -J4; -J5; 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULO DE a, c, d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=G\b1;
c=G\b2;
d=G\b0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPRESION EN CONSOLA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n============================================\n')
fprintf('PUNTO DE PRUEBA\n')
fprintf('E1 = %.2f V\n', E1_test)
fprintf('E2 = %.2f V\n', E2_test)
fprintf('============================================\n\n')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULO DE TENSIONES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U_test = E1_test*a + E2_test*c + d;

fprintf('TENSIONES NODALES:\n')
for i=1:6
    fprintf('U%d = %.4f V\n', i, U_test(i))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VERIFICACION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if all(U_test>=95 & U_test<=105)
    fprintf('\n>>> EL PUNTO ES FACTIBLE <<<\n')
else
    fprintf('\n>>> EL PUNTO NO ES FACTIBLE <<<\n')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGION FACTIBLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAFICO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(Ef1,Ef2,'b.','markersize',8)
grid on
xlabel('E1 [V]')
ylabel('E2 [V]')
title('Region factible de (E1,E2)')
axis equal

hold on

%PUNTO DE PRUEBA
plot(E1_test,E2_test,'ro','markersize',10,'linewidth',2)

%ETIQUETA DINAMICA
label_punto = sprintf('(E1 = %.1f V, E2 = %.1f V)', E1_test, E2_test);
text(E1_test+0.3, E2_test, label_punto)

%CONTORNO
if ~isempty(Ef1)
    K=convhull(Ef1,Ef2);
    plot(Ef1(K),Ef2(K),'r-','linewidth',2)

    legend('Puntos factibles', label_punto, 'Contorno')
else
    legend('Puntos factibles', label_punto)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOSTRAR ECUACIONES NODALES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n============================================\n')
fprintf('INECUACIONES NODALES:\n')
for i=1:6
    fprintf('Nodo %d: 95 <= %.6f*E1 + %.6f*E2 + %.6f <= 105\n', i, a(i), c(i), d(i));
end
fprintf('============================================\n')
