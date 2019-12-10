clear all;close all;clc;
%scrittura della funzione obiettivo 
%punti di campionamento asse x
%intervallo campionamento xa-xb
xa = -0.05;
xb = 0.05;
%punti di campionamento asse y
yc = 0;
%lambda funzione desiderata
lambda = [25 50 35 10].* (1e-09);
%punti in cui si trovano i 4 fili 
P1 =  [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];
%vettore punti che passo alla funzione obiettivo 
P = [P1;P2;P3;P4];

%funzione che fa la norma quadra del campo Exy dato da un solo filo
%nell'intervallo [-0.05, 0.05]


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
X = [lambda(2), lambda(3),lambda(4)];
test_params = struct( ...
    'dimension', 3, ...
    'plot', true, ...
    'minimum', X, ...
    'sampling_step', 0.01, ...
    'sampling_range', 0.05, ...
    'sample_amount', -1, ...
    'max_flips', 1000000, ...
    'tolerance', 1e-12, ...
    'minLength', 1e-13, ...
    'start_point', [7.5e-08 3e-08 4e-08], ...
    'length', 2e-9...
);

xc = -test_params.sampling_range:test_params.sampling_step:test_params.sampling_range; %xc =-0.05:0.01:0.05
test_params.sample_amount = length(xc); %NP
disp("Test parameters")
disp(test_params)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%crimine inverso: mi creo il campo con valori lambda prefissati 
Edesideratax = Etotx(P,xc,yc,lambda);
%disegno campo Desiderato variabile
% figure(1)
% plot(xc,Edesideratax)
% grid on

%Edesiderata funzione media
%Edesideratax = mean(Etotx(P,xc,yc,lambda));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scrittura funzione obj normalizzata dei campi proiettati lungo l'asse x
%fo dipendende da una variabile lmbd 
bounds = {};
%fo =@(lmbd) (1/mean(Edesideratax))* sqrt((xb-xa)/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lambda(2),lmbd,lambda(4)]));
%f1 dipende da due variabili (lmbd1,lmbd2)
%f1 =@(lmbd1,lmbd2) (1/mean(Edesideratax))* sqrt((xb-xa)/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lmbd1,lmbd2,lambda(4)]));
f2 =@(lmbd)(1/mean(Edesideratax))* sqrt(1/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lmbd(1),lmbd(2),lmbd(3)]));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%funzioni obiettivo con proiezione su asse x e asse y
% fo = @(lmbd) (1/mean(Edesiderata))* sqrt((xb-xa)/length(xc))* norm(Edesiderata - [Etotx(P,xc,yc,[lambda(1),lambda(2),lmbd,lambda(4)]); Etoty(P,xc,yc,[lambda(1),lambda(2),lmbd,lambda(4)])]);
% f1 = @(lmbd1,lmbd2) (1/mean(Edesiderata))* sqrt((xb-xa)/length(xc))* norm(Edesiderata - [Etotx(P,xc,yc,[lmbd1,lambda(2),lmbd2,lambda(4)]); Etoty(P,xc,yc,[lmbd1,lambda(2),lmbd2,lambda(4)])]);
% f2 = @(lmbd1,lmbd2,lmbd3)(1/mean(Edesiderata))* sqrt((xb-xa)/length(xc))* norm(Edesiderata - [Etotx(P,xc,yc,[lmbd1,lambda(2),lmbd2,lmbd3]); Etoty(P,xc,yc,[lmbd1,lambda(2),lmbd2,lmbd3])]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simplex algorythm
settings = struct('step', test_params.sampling_step, 'slices', floor(length(xc)), 'plot', test_params.plot, 'dimension', test_params.dimension);
range = struct('Xmin', 0e-06, 'Xmax', 10e-06, 'Ymin', 0e-06, 'Ymax', 10e-06,'Zmin', 0e-06, 'Zmax', 10e-06);
stop_conditions = struct('maxFlips', test_params.max_flips, 'tolerance', test_params.tolerance, 'minLength', test_params.minLength);
start_conditions = struct('start', test_params.start_point, 'length', test_params.length);
obj = NelderMeadMethod(f2, bounds, stop_conditions, start_conditions, settings, range);
% display results
disp("Results")
disp(obj.getResults());
dumpResults(test_params, obj.getResults());
if test_params.plot
    % label
    xlabel('{\lambda}2 [C/m]');
    ylabel('{\lambda}3 [C/m]');
    zlabel('{\lambda}4 [C/m]');
    % plot ideal minimum
    figure(1);
    plot3(X(1), X(2),X(3), 'x', 'color', 'y', 'lineWidth', 1.5);
    grid on;
end