%prende l'handler della funzione e lo va a valutare nell'intervallo di
%valori val
%restituisce il vettore di valori v, ho creato questa funzione perch� poi
%fare il plot dell'hanlder � molto pi� semplice perch� basta fare 
%plot(intervallo, v)
function res = fo2Deval(fo,val)
    A = zeros([1,length(val)]);
  
    for i = 1:length(val)
         A(i) = fo(val(i));
    end
    res = A;
end