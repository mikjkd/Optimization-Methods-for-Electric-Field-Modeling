%funzione campo risultante dato dai 4 fili 
function res = Etoty(Pv, Xv, Yv, Lv)
   [Ex1, Ey1] = Exy(Pv(1,:), Xv, Yv, Lv(1));
   [Ex2, Ey2] = Exy(Pv(2,:), Xv, Yv, Lv(2));
   [Ex3, Ey3] = Exy(Pv(3,:), Xv, Yv, Lv(3));
   [Ex4, Ey4] = Exy(Pv(4,:), Xv, Yv, Lv(4));
   res = Ey1+Ey2+Ey3+Ey4;
end