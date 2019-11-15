%voglio il campo nei punti (x,y) dato dal filo nel punto P con densità di
%carica lambda

function res = Exy(P,xc,yc,lambda) 
    xf = P(1);
    yf = P(2);
    eps0 = 8.85e-12;
    res = (lambda)./((2*pi*eps0)*sqrt((xf-xc).^2+(yf-yc).^2));
end
