%voglio il campo nei punti (x,y) dato dal filo nel punto P con densità di
%carica lambda
%P = [xf, yf] coordinata in cui si trova il filo
%xc = coordinate x dove vado a valutare il campo
%yc = coordinate y dove vado a valutare il campo
%lambda = valori di lambda del filo

function [Ex,Ey] = Exy(P,xc,yc,lambda) 
    xf = P(1);
    yf = P(2);
    eps0 = 8.85e-12;
    Ex = (lambda.*(xc-xf))./((2*pi*eps0).*((xc-xf).^2+(yc-yf).^2));
    Ey = (lambda.*(yc-yf))./((2*pi*eps0).*((xc-xf).^2+(yc-yf).^2));
end
