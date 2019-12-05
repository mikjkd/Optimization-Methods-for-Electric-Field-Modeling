clear all, close all, clc;
%scrittura della funzione obiettivo 
%punti di campionamento asse x
xc = -0.05:0.01:0.05;
%intervallo campionamento xa-xb
xa = -0.05;
xb = 0.05;
%punti di campionamento asse y
yc = 0;
%lambda funzione desiderata
lambda = [25 50 35 10].* (1e-09);
%punti in cui si trovano i 4 fili 
P1 = [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];
%vettore punti che passo alla funzione obiettivo 
P = [P1;P2;P3;P4];

%funzione che fa la norma quadra del campo Exy dato da un solo filo
%nell'intervallo [-0.05, 0.05]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Edesiderata costante 
Edesideratax = 2.647574645275561e+03;
%disegno campo Desiderato variabile
figure(1)
plot(xc,Edesideratax*ones(1,length(xc)));
xlabel('x [m]');
ylabel('Edesiderato [V/m]');
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scrittura funzione obj normalizzata dei campi proiettati lungo l'asse x
%fo dipendende da una variabile lmbd 
fo =@(lmbd) (1/mean(Edesideratax))* sqrt(1/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lambda(2),lmbd(1),lambda(4)]));
%f1 dipende da due variabili (lmbd1,lmbd2)
f1 =@(lmbd) (1/mean(Edesideratax))* sqrt(1/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lmbd(1),lmbd(2),lambda(4)]));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%istruzioni per graficare fobj
%dove faccio variare lmbd1 per fare la ricerca del minimo
passo1 = 1e-9:0.5e-8:2e-7;
%%plot (X, Y)
%grafico in 1 var
figure(2)
%subplot(1,2,1)
plot(passo1,fo2Deval(fo,passo1));
grid
xlabel('{\lambda}3 [C/m]');
ylabel('fobj({\lambda}3)');
%mi creo i punti da graficare in 2 var
%grafico in 2 var
vs = fo3Deval(f1,passo1,passo1);
figure(3);
%subplot(1,2,2)
[X,Y] = meshgrid(passo1,passo1);
surf(X,Y,vs)
grid on
hold on
%linee di livello
contour(X,Y,vs,20)
colorbar
xlabel('{\lambda}2 [C/m]');
ylabel('{\lambda}3 [C/m]');
zlabel('fobj({\lambda}2,{\lambda}3)');
