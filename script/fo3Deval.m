%prende l'handler della funzione e lo va a valutare nell'intervallo di
%valori val
%e' una funzione in 2 var, quindi un grafico in 3D
%restituisce il vettore di valori v, ho creato questa funzione perchè poi
%fare il plot dell'hanlder è molto più semplice perchè basta fare 
%surf(intervallo1,intervallo2, v)
function res = fo3Deval(fo,val1,val2)
    [X,Y] = meshgrid(val1,val2);
    lenX = length(X);
    lenY = length(Y);
    V = zeros(lenX, lenY);
    for i = 1:lenX
        for j = 1:lenY
            V(i, j) = fo([X(i,j), Y(i,j)]);
        end
    end
    res = V;
end