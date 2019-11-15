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

f1 = norm(Etot(P, xc, yc, lambda));
f2 = norm(Exy(P1,xc,yc,lambda(1)));
%funzione che fa la norma quadra del campo Exy dato da un solo filo
%nell'intervallo [-0.05, 0.05]

f3 = sqrt((xb-xa)/length(xc))*norm(Exy(P1,xc,yc,lambda(1)))


    
function res = Etot(Pv, Xv, Yv, Lv)
    res = Exy(Pv(1,:), Xv, Yv, Lv(1)) + Exy(Pv(2,:), Xv, Yv, Lv(2)) + Exy(Pv(2,:), Xv, Yv, Lv(3)) + Exy(Pv(4,:), Xv, Yv, Lv(4));
end