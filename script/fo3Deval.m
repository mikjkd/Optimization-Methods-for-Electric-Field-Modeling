%prende l'handler della funzione e lo va a valutare nell'intervallo di
%valori val
%e' una funzione in 2 var, quindi un grafico in 3D
%restituisce il vettore di valori v, ho creato questa funzione perchè poi
%fare il plot dell'hanlder è molto più semplice perchè basta fare 
%surf(intervallo1,intervallo2, v)
function v = fo3Deval(fo,val1,val2)
    [X,Y] = meshgrid(val1,val2);
    s = size(X);
    B = [];
    A = [];
    for i = 1:s(1)

        for j = 1:s(2)
            B= [ B, fo(X(i,j),Y(i,j))];
        end
        
        A = [A; B];
        B = [];
    end
    
    v = A;
end