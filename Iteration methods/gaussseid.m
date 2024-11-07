function x = gaussseid_function(A,b, maxLepes)

n = length(b);
x = zeros(n,1);
hibakorlat = 1e-6;

% A mátrixot LDU-ra kell felbontani
L = tril(A, -1);
D = diag(diag(A));
U = triu(A, 1);

    for k = 1:maxLepes
            x_old = x;
            % X felülírható (nincs szükség rá az x^i+1 számolásához (num03_23HO.pdf)
    
            x = (D + L) \ (-U * x + b);
            if norm(x - x_old, inf) < hibakorlat
                disp(['Az iteráció ' num2str(k) ' lépésben'])
                break;
            end
    end
end



% PÉLDA FÜGGVÉNYHÍVÁS!
A = [5 1 -2; -1 4 2; 0 3 4];
b = [2; 5; 1];
maxLepes = 100;
megoldas = gaussseid_function(A, b, maxLepes);
disp('A Gauss-Seidel módszerrel számított megoldás:')
disp(megoldas)
