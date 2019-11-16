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

%f1 = sqrt((xb-xa)./length(xc)).*norm(Exy(P1,xc,yc,lambda(1)))

%scrittura funzione obj
fo =  @(lmbd1) (1/mean(Etot(P,xc,yc,[lambda(1),lambda(2),lambda(3),lambda(4)])))*sqrt((xb-xa)/length(xc))*norm( Etot(P,xc,yc,[lambda(1),lambda(2),lambda(3),lambda(4)]) - Etot(P,xc,yc,[lambda(1),lmbd1,lambda(3),lambda(4)]))
passo1 = 1e-08:0.000000000001:10e-08;
foval(fo,100e-09)

    
function res = Etot(Pv, Xv, Yv, Lv)
    res = Exy(Pv(1,:), Xv, Yv, Lv(1)) + Exy(Pv(2,:), Xv, Yv, Lv(2)) + Exy(Pv(3,:), Xv, Yv, Lv(3)) + Exy(Pv(4,:), Xv, Yv, Lv(4));
end
function foval(fo,val)
    for i = 1:length(val)
         A = fo(val(i))
    end
end
function foplot(fo,val)
    if isa(fo, 'function_handle')
        for i = 1:length(val)
            A = fo(val(i));
            plot(val(i),A,'o')
            hold on
        end
    end
end