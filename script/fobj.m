%scrittura della funzione obiettivo 

xc = -0.05:0.0001:0.05;
xa = -0.05;
xb = 0.05;
yc = 0;
lambda = [25 50 35 10].* (1e-09);
P1 =  [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];
P = [P1;P2;P3;P4];

%funzione che fa la norma quadra del campo Exy dato da un solo filo
%nell'intervallo [-0.05, 0.05]
Edesiderata = Etot(P,xc,yc,[lambda(1),lambda(2),lambda(3),lambda(4)]);
%scrittura funzione obj normalizzata
fo =  @(lmbd1) (1/mean(Edesiderata))*sqrt((xb-xa)/length(xc))*norm(Edesiderata - Etot(P,xc,yc,[lambda(1),lmbd1,lambda(3),lambda(4)]))
passo1 = 1e-08:0.0000000001:10e-08;
foval(fo,passo1);
foplot(fo,passo1);


%prende l'handler della funzione e lo va a valutare nell'intervallo di
%valori val
function foval(fo,val)
    for i = 1:length(val)
         A = fo(val(i));
    end
end
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