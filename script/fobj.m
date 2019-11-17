%scrittura della funzione obiettivo 
%punti di campionamento
xc = -0.05:0.0001:0.05;
%intervallo campionamento xa-xb
xa = -0.05;
xb = 0.05;
%punti di campionamento su y
yc = 0;
%lambda funzione desiderata
lambda = [25 50 35 10].* (1e-09);
%punti in cui si trovano i 4 fili 
P1 =  [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];
%vettore che passo alla funzione obiettivo 
P = [P1;P2;P3;P4];

%funzione che fa la norma quadra del campo Exy dato da un solo filo
%nell'intervallo [-0.05, 0.05]
%Edesiderata = Etot(P,xc,yc,[lambda(1),lambda(2),lambda(3),lambda(4)]);
Edesiderata = 2.8563e+04;
%scrittura funzione obj normalizzata
%fo dipendende da una variabile lmbd1
fo =  @(lmbd1) (1/mean(Edesiderata))*sqrt((xb-xa)/length(xc))*norm(Edesiderata - Etot(P,xc,yc,[lambda(1),lmbd1,lambda(3),lambda(4)]));
%fo dipendende da due variabili lmbd1 e lmbd2
f1 = @(lmbd1,lmbd2) (1/mean(Edesiderata))*sqrt((xb-xa)/length(xc))*norm(Edesiderata - Etot(P,xc,yc,[lambda(1),lmbd1,lmbd2,lambda(4)]));
 
%dove faccio variare lmbd1 per fare la ricerca del minimo in 1 variabile
passo1 = 1e-08:0.000000001:10e-08;
%%plot (X, Y)
subplot(2,1,1)
plot(passo1,fo2Deval(fo,passo1));
grid
title('Lambda 2');
%mi creo i punti da graficare in 2 var
vs = fo3Deval(f1,passo1,passo1);
subplot(2,1,2)
surf(passo1,passo1,vs)
title('Lambda 2 - Lambda 3');


%plotto come faria fo al variare di lmbd1
%foplot(fo,passo1);


%prende l'handler della funzione e lo va a plottare nell'intervallo di
%valori val
function foplot(fo,val)
    if isa(fo, 'function_handle')
        for i = 1:length(val)
            A = fo(val(i));
            plot(val(i),A,'o')
            hold on
        end
    end
end