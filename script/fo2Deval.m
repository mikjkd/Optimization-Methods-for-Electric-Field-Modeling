%prende l'handler della funzione e lo va a valutare nell'intervallo di
%valori val
%restituisce il vettore di valori v, ho creato questa funzione perchè poi
%fare il plot dell'hanlder è molto più semplice perchè basta fare 
%plot(intervallo, v)
function res = fo2Deval(fo,val)
    A = zeros([1,length(val)]);
  
    for i = 1:length(val)
         A(i) = fo(val(i));
    end
    res = A;
end