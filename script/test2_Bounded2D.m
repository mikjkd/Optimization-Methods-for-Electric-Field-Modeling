%scrittura della funzione obiettivo 
%punti di campionamento asse x
%intervallo campionamento xa-xb
xa = -0.05;
xb = 0.05;
%punti di campionamento asse y
yc = 0;
%lambda funzione desiderata
lambda = [25 50 35 10].* (1e-06);
%punti in cui si trovano i 4 fili 
P1 =  [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];
%vettore punti che passo alla funzione obiettivo 
P = [P1;P2;P3;P4];

X = [lambda(2), lambda(3)];
test_params = struct( ...
    'dimension', 2, ...
    'plot', true, ...
    'minimum', X, ...
    'sampling_step', 0.01, ...
    'sampling_range', 0.05, ...
    'sample_amount', -1, ...
    'max_flips', 1000, ...
    'tolerance', 0.1, ...
    'minLength', 1e-7, ...
    'start_point', [5.1e-05 2.3e-05], ...
    'length', 1e-05...
);

xc = -test_params.sampling_range:test_params.sampling_step:test_params.sampling_range; %xc =-0.05:0.01:0.05
test_params.sample_amount = length(xc); %NP
disp("Test parameters")
disp(test_params)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%crimine inverso: mi creo il campo con valori lambda prefissati 
Edesideratax = Etotx(P,xc,yc,lambda);
%disegno campo Desiderato variabile
 figure(1)
 plot(xc,Edesideratax)
 grid on

bounds = {};

fo =@(lmbd) (1/mean(Edesideratax))* sqrt((xb-xa)/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lambda(2),lmbd,lambda(4)]));
%f1 dipende da due variabili (lmbd1,lmbd2)
f1 =@(lmbd1,lmbd2) (1/mean(Edesideratax))* sqrt((xb-xa)/length(xc))* norm(Edesideratax - Etotx(P,xc,yc,[lambda(1),lmbd1,1.5*lmbd1,lambda(4)]));

% simplex algorythm
settings = struct('step', test_params.sampling_step, 'slices', floor(length(xc)), 'plot', test_params.plot, 'dimension', test_params.dimension);
range = struct('Xmin', 4e-05, 'Xmax', 7e-05, 'Ymin', 1e-05, 'Ymax', 4e-05 );
stop_conditions = struct('maxFlips', test_params.max_flips, 'tolerance', test_params.tolerance, 'minLength', test_params.minLength);
start_conditions = struct('start', test_params.start_point, 'length', test_params.length);
obj = NelderMeadMethod(f1, bounds, stop_conditions, start_conditions, settings, range);
% display results
disp("Results")
disp(obj.getResults());
dumpResults(test_params, obj.getResults());
if test_params.plot
    % label
    xlabel('Lambda 1');
    ylabel('Lambda 2');
    % plot ideal minimum
    plot(X(1), X(2), 'x', 'color', 'y', 'lineWidth', 1.5);
    grid on;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%istruzioni per graficare fobj
%dove faccio variare lmbd1 per fare la ricerca del minimo
passo1 = 1e-5:1e-6:1e-4;
%%plot (X, Y)
%grafico in 1 var
figure(2)
subplot(1,2,1)
plot(passo1,fo2Deval(fo,passo1));
grid
title('Lambda 2');
%mi creo i punti da graficare in 2 var
%grafico in 2 var
vs = fo3Deval(f1,passo1,passo1);
subplot(1,2,2)
[X,Y] = meshgrid(passo1,passo1);
surf(X,Y,vs)
colorbar
title('Lambda 2 - Lambda 3');
%linee di livello
figure(3)
contour(X,Y,vs,20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% function res = Etotx(Pv, Xv, Yv, Lv)
%    [Ex1, Ey1] = Exy(Pv(1,:), Xv, Yv, Lv(1));
%    [Ex2, Ey2] = Exy(Pv(2,:), Xv, Yv, Lv(2));
%    [Ex3, Ey3] = Exy(Pv(3,:), Xv, Yv, 2*Lv(2));
%    [Ex4, Ey4] = Exy(Pv(4,:), Xv, Yv, Lv(4));
%    res = Ex1+Ex2+Ex3+Ex4;
%    
% end
