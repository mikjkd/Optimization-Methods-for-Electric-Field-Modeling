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
P1 = [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];
%vettore punti che passo alla funzione obiettivo 
P = [P1;P2;P3;P4];

%funzione che fa la norma quadra del campo Exy dato da un solo filo
%nell'intervallo [-0.05, 0.05]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = [1,1];
test_params = struct( ...
    'dimension', 2, ...
    'plot', true, ...
    'minimum', X, ...
    'sampling_step', 0.01, ...
    'sampling_range', 0.05, ...
    'sample_amount', -1, ...
    'max_flips', 500, ...
    'tolerance', 1e-12, ...
    'minLength', 1e-10, ...
    'start_point', [0.8e-08 5.6e-08], ...
    'length', 1.5e-9...
);

xc = -test_params.sampling_range:test_params.sampling_step:test_params.sampling_range; %xc =-0.05:0.01:0.05
test_params.sample_amount = length(xc); %NP
disp("Test parameters")
disp(test_params)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Edesiderata costante 
Edesideratax = 2.647574645275561e+03;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scrittura funzione obj normalizzata dei campi proiettati lungo l'asse x
%fo dipendende da una variabile lmbd 
bounds = {};
%f1 dipende da due variabili (lmbd1,lmbd2)
f1 =@(lmbd) (1/mean(Edesideratax))* sqrt((xb-xa)/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lmbd(1),lmbd(2),lambda(4)]));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% simplex algorythm
settings = struct('step', test_params.sampling_step, 'slices', floor(length(xc)), 'plot', test_params.plot, 'dimension', test_params.dimension);
range = struct('Xmin', 0e-07, 'Xmax', 1e-07, 'Ymin', 0e-07, 'Ymax', 1e-07);
stop_conditions = struct('maxFlips', test_params.max_flips, 'tolerance', test_params.tolerance, 'minLength', test_params.minLength);
start_conditions = struct('start', test_params.start_point, 'length', test_params.length);
obj = NelderMeadMethod(f1, bounds, stop_conditions, start_conditions, settings, range);
% display results
disp("Results")
disp(obj.getResults());
dumpResults(test_params, obj.getResults());
if test_params.plot
    % label
    xlabel('{\lambda}2');
    ylabel('{\lambda}3');
    % plot ideal minimum
    figure(1);
    plot(X(1), X(2), 'x', 'color', 'y', 'lineWidth', 1.5);
    grid on;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%