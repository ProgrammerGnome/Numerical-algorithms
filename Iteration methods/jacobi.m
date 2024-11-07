function x = jacobi_function(A, b, maxLepes)
    n = length(b);
    x = zeros(n, 1);
    x_old = x;
    hibakorlat = 1e-6;

    [m, ~] = size(A);
    if m ~= n
        error('A mátrixnak négyzetesnek kell lennie!');
    end

    for k = 1:maxLepes
        for i = 1:n
            sigma = A(i, :) * x_old - A(i, i) * x_old(i);
            x(i) = (b(i) - sigma) / A(i, i);
        end
        
        if norm(x - x_old, inf) < hibakorlat
            disp(['Az iteráció ' num2str(k) ' lépésben megállt.']);
            break;
        end
        
        x_old = x;
        
        if k == maxLepes
            disp("Az iterációk száma elérte a maximális lépésszámot!");
        end
    end
end



% PÉLDA FÜGGVÉNYHÍVÁS!
A = [5 1 -2; -1 4 2; 0 3 4];
b = [2; 5; 1];
maxLepes = 100;
megoldas = jacobi_function(A, b, maxLepes);
disp('A Jacobi-módszerrel számított megoldás:')
disp(megoldas)
