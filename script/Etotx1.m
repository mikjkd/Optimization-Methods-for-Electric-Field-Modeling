function res = Etotx1(Pv, Xv, Yv, Lv)
   [Ex1, Ey1] = Exy(Pv(1,:), Xv, Yv, Lv(1));
   [Ex2, Ey2] = Exy(Pv(2,:), Xv, Yv, Lv(2));
   [Ex3, Ey3] = Exy(Pv(3,:), Xv, Yv, 1.5*Lv(2));
   [Ex4, Ey4] = Exy(Pv(4,:), Xv, Yv, Lv(4));
   res = Ex1+Ex2+Ex3+Ex4;
   
end