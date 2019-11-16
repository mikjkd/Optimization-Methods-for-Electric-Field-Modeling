%funzione campo risultante dato dai 4 fili 
function res = Etot(Pv, Xv, Yv, Lv)
    res = Exy(Pv(1,:), Xv, Yv, Lv(1)) + Exy(Pv(2,:), Xv, Yv, Lv(2)) + Exy(Pv(3,:), Xv, Yv, Lv(3)) + Exy(Pv(4,:), Xv, Yv, Lv(4));
end