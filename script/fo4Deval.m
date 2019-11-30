
function v = fo4Deval(fo,val1,val2,val3)
    [X,Y,Z] = meshgrid(val1,val2,val3);
    s = size(X);
    C = [];
    B = [];
    A = [];
    
    for i = 1:s(1)

        for j = 1:s(2)
            for k = 1:s(3)
                C= [ C, fo(X(i,j,k),Y(i,j,k),Z(i,j,k))];
            end
            B = [B; C];
            C = [];
        end
        A = [A; B];
        B = [];
    end
    
    v = A;
end