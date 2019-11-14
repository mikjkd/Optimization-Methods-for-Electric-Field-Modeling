%scrittura della funzione obiettivo 

xc = -5:0.1:5;
yc = 0;
lambda = [25 50 35 10].* (1e-09);
P1 =  [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];


    
function res = Etot(Pv, Xv, Yv, Lv)
    P1 = Pv(1);
    P2 = Pv(2);
end