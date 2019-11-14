function res = Exy(P,x,y,lambda) 
    xf = P[0]
    yf = P[1]
    eps0 = 8.85e-12
    res = (lambda)./((2*pi*eps0)*sqrt((xf-x)^2+(yf-y)^2))
end