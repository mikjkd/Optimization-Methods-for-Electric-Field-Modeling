%prende l'handler della funzione e lo va a valutare nell'intervallo di
%valori val
%restituisce il vettore di valori v, ho creato questa funzione perch� poi
%fare il plot dell'hanlder � molto pi� semplice perch� basta fare 
%plot(intervallo, v)
function v = foeval(fo,val)
    A = [];
    for i = 1:length(val)
         A= [ A, fo(val(i))];
    end
    v = A;
end