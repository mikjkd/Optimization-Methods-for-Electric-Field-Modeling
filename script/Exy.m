%voglio il campo nei punti (x,y) dato dal filo nel punto P con densit� di
%carica lambda

function res = Exy(P,x,y,lambda) 
    xf = P[0]
    yf = P[1]
    eps0 = 8.85e-12
    res = (lambda)./((2*pi*eps0)*sqrt((xf-xc)^2+(yf-yc)^2))
end
