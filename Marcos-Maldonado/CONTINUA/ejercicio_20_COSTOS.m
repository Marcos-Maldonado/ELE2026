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
E2_test = 90;

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

IE1_test = (E1_test - U_test(1))/r10;
IE2_test = (E2_test - U_test(6))/r60;
PE1_test = E1_test * IE1_test;
PE2_test = E2_test * IE2_test;
C_test   = 2*PE1_test + PE2_test;

fprintf('\nCORRIENTES DE FUENTE EN EL PUNTO DE PRUEBA:\n')
fprintf('IE1 = %.4f A\n', IE1_test)
fprintf('IE2 = %.4f A\n', IE2_test)

fprintf('\nPOTENCIAS EN EL PUNTO DE PRUEBA:\n')
fprintf('PE1 = %.4f W\n', PE1_test)
fprintf('PE2 = %.4f W\n', PE2_test)

fprintf('\nCOSTO EN EL PUNTO DE PRUEBA:\n')
fprintf('C = 2*PE1 + PE2 = %.4f\n', C_test)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VERIFICACION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if all(U_test>=95 & U_test<=105)
    fprintf('\n>>> EL PUNTO ES FACTIBLE <<<\n')
else
    fprintf('\n>>> EL PUNTO NO ES FACTIBLE <<<\n')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGION FACTIBLE + COSTO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E1_vals=90:0.05:112;
E2_vals=90:0.05:112;

Ef1=[];
Ef2=[];
Cf=[];

for E1=E1_vals
    for E2=E2_vals
        U=E1*a + E2*c + d;

        if all(U>=95 & U<=105)
            IE1 = (E1 - U(1))/r10;
            IE2 = (E2 - U(6))/r60;

            PE1 = E1*IE1;
            PE2 = E2*IE2;

            C = 2*PE1 + PE2;

            Ef1(end+1)=E1;
            Ef2(end+1)=E2;
            Cf(end+1)=C;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BUSQUEDA DEL MINIMO COSTO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(Cf)
    [Cmin, idx] = min(Cf);
    E1_opt = Ef1(idx);
    E2_opt = Ef2(idx);

    U_opt = E1_opt*a + E2_opt*c + d;
    IE1_opt = (E1_opt - U_opt(1))/r10;
    IE2_opt = (E2_opt - U_opt(6))/r60;
    PE1_opt = E1_opt * IE1_opt;
    PE2_opt = E2_opt * IE2_opt;

    fprintf('\n============================================\n')
    fprintf('PUNTO OPTIMO (COSTO MINIMO)\n')
    fprintf('E1_opt = %.4f V\n', E1_opt)
    fprintf('E2_opt = %.4f V\n', E2_opt)
    fprintf('Cmin   = %.4f\n', Cmin)
    fprintf('PE1_opt = %.4f W\n', PE1_opt)
    fprintf('PE2_opt = %.4f W\n', PE2_opt)
    fprintf('============================================\n')
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

% Punto de prueba
plot(E1_test,E2_test,'ro','markersize',10,'linewidth',2)
label_test = sprintf('Prueba: (E1 = %.1f V, E2 = %.1f V)', E1_test, E2_test);
text(E1_test+0.3, E2_test, label_test)

% Contorno
if ~isempty(Ef1)
    K=convhull(Ef1,Ef2);
    plot(Ef1(K),Ef2(K),'r-','linewidth',2)
end

% Punto óptimo
if ~isempty(Cf)
    plot(E1_opt,E2_opt,'ks','markersize',10,'linewidth',2)
    label_opt = sprintf('Optimo: (E1 = %.2f V, E2 = %.2f V)', E1_opt, E2_opt);
    text(E1_opt+0.3, E2_opt, label_opt)
    legend('Puntos factibles', 'Punto de prueba', 'Contorno', 'Punto optimo')
else
    legend('Puntos factibles', 'Punto de prueba')
end
