%calcolo il campo totale su una retta

lambda = [25 50 35 10].* (1e-09);

P1 =  [0.08 0];
P2 = [0 0.08];
P3 = [-0.08 0];
P4 = [0 -0.08];

res1 = Exy(P1, 0, 0, lambda(1));
res2 = Exy(P2,0, 0, lambda(2));
res3 = Exy(P3, 0, 0, lambda(3));
res4 = Exy(P4, 0, 0, lambda(4));

rtot = res1+res2+res3+res4
