clear all; close all; clc;
%scrittura della funzione obiettivo 
%punti di campionamento asse x
xc = -0.05:0.001:0.05;
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
%crimine inverso: mi creo il campo con valori lambda prefissati 
Edesideratax = Etotx(P,xc,yc,lambda);
%disegno campo Desiderato variabile
figure(1)
plot(xc,Edesideratax)
xlabel('x [m]');
ylabel('Edesiderato [V/m]');
grid on

%Edesiderata funzione media
%Edesideratax = mean(Etotx(P,xc,yc,lambda));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%proiezione campo desiderato su asse y
%per ora usiamo solo x
%Edesideratay = 2.8563e+04;

%Edesideratay funzione media
%Edesideratay = mean(Etoty(P,xc,yc,lambda));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vautazione edesiderata a due variabili
%Edesiderata =  [Edesideratax; Edesideratay];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scrittura funzione obj normalizzata dei campi proiettati lungo l'asse x
%fo dipendende da una variabile lmbd 
fo =@(lmbd) (1/mean(Edesideratax))* sqrt(1/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lambda(2),lmbd(1),lambda(4)]));
%f1 dipende da due variabili (lmbd1,lmbd2)
f1 =@(lmbd) (1/mean(Edesideratax))* sqrt(1/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lmbd(1),lmbd(2),lambda(4)]));
%f2 dipende da due variabili (lmbd1,lmbd2,lmbd3)
%f2 =@(lmbd1,lmbd3,lmbd4) (1/mean(Edesideratax))* sqrt((xb-xa)/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lmbd1,lambda(2),lmbd3,lmbd4]));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%funzioni obiettivo con proiezione su asse x e asse y
% fo = @(lmbd) (1/mean(Edesiderata))* sqrt((xb-xa)/length(xc))* norm(Edesiderata - [Etotx(P,xc,yc,[lambda(1),lambda(2),lmbd,lambda(4)]); Etoty(P,xc,yc,[lambda(1),lambda(2),lmbd,lambda(4)])]);
% f1 = @(lmbd1,lmbd2) (1/mean(Edesiderata))* sqrt((xb-xa)/length(xc))* norm(Edesiderata - [Etotx(P,xc,yc,[lmbd1,lambda(2),lmbd2,lambda(4)]); Etoty(P,xc,yc,[lmbd1,lambda(2),lmbd2,lambda(4)])]);
% f2 = @(lmbd1,lmbd2,lmbd3)(1/mean(Edesiderata))* sqrt((xb-xa)/length(xc))* norm(Edesiderata - [Etotx(P,xc,yc,[lmbd1,lambda(2),lmbd2,lmbd3]); Etoty(P,xc,yc,[lmbd1,lambda(2),lmbd2,lmbd3])]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%istruzioni per graficare fobj
%dove faccio variare lmbd1 per fare la ricerca del minimo
passo1 = 1e-9:1e-9:1e-7;
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
