%voglio il campo nei punti (x,y) dato dal filo nel punto P con densità di
%carica lambda

function res = Exy(P,x,y,lambda) 
<<<<<<< HEAD
    xf = P(1);
    yf = P(2);
    eps0 = 8.85e-12;
    res = (lambda)/((2*pi*eps0)*sqrt((xf-x)^2+(yf-y)^2));
=======
    xf = P[0]
    yf = P[1]
    eps0 = 8.85e-12
    res = (lambda)./((2*pi*eps0)*sqrt((xf-xc)^2+(yf-yc)^2))
>>>>>>> b091d37a6c2f1e49e3cab30ec32f3cfb8bf6ab93
end
