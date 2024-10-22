function X = gaussel2_lu_function(A, B, verbose, verbose2, pivot_type)
    % GAUSSEL2_LU_FUNCTION Gauss elimináció és LU felbontás egy függvényben.
    % Bemenetek:
    %   A - Az egyenletrendszer mátrixa.
    %   B - Jobboldali vektor(ok).
    %   verbose - Köztes lépések kiírását vezérli (Li esetben)
    %   verbose2 - Köztes lépések kiírását vezérli (A(i) esetben)
    %   pivot_type - 'partial' (részleges) vagy 'full' (teljes) főelemkiválasztás.
    %
    % Visszatérés:
    %   X - A megoldásvektor(ok).

    disp("A megadott mátrix a következőképp néz ki: ");
    disp(A);
    
    if nargin < 3
        verbose = false; % Alapértelmezés: hamis
    end
    if nargin < 4
        verbose2 = false; % Alapértelmezés: hamis
    end
    if nargin < 5
        pivot_type = 'partial'; % Alapértelmezett: részleges főelemkiválasztás
    end

    % Méret ellenőrzés
    [m, n] = size(A);
    [mb, nb] = size(B);
    if m ~= mb
        error('A mátrix és a jobboldali vektor(ok) mérete nem egyezik.');
    end
    
    % Kezdeti L és U mátrixok
    L = eye(m);
    U = A;

    % LU felbontás végrehajtása
    for k = 1:m-1
        % Ellenőrizzük, hogy a főelem nem nulla-e
        if U(k, k) == 0
            error('A mátrix szinguláris, nincs egyértelmű LU felbontás.');
        end

        % Elimináció
        for i = k+1:m
            factor = U(i, k) / U(k, k);
            U(i, k:m) = U(i, k:m) - factor * U(k, k:m);
            L(i, k) = factor;
        end

        % Köztes lépések kiírása, ha szükséges
        if verbose
            fprintf('L(%d):\n', k);
            disp(L);
            fprintf('U(%d):\n', k);
            disp(U);
        end
    end

    if verbose
        disp('LU felbontás kész:');
        disp('Az L mátrix:');
        disp(L);
        disp('Az U mátrix:');
        disp(U);
    end

    % Az összes megoldás tárolására szolgáló mátrix
    X_temp = zeros(n, nb);

    % Minden jobboldali vektorhoz külön végrehajtjuk a Gauss-eliminációt párhuzamosan
    parfor j = 1:nb
        b = B(:, j);
        Ab = [A b];
        local_pivot_type = pivot_type;

        if verbose2
            disp(['Jobboldali vektor ' num2str(j) ':']);
            disp(b);
        end

        for k = 1:min(m, n)
            switch local_pivot_type
                case 'partial'
                    [max_val, max_row] = max(abs(Ab(k:m, k)));
                    max_row = max_row + k - 1;
                    if max_val == 0
                        local_pivot_type = 'full';
                    end
                case 'full'
                    [max_val, max_idx] = max(abs(Ab(k:m, k:n)), [], 'all', 'linear');
                    [row_offset, col_offset] = ind2sub([m - k + 1, n - k + 1], max_idx);
                    max_row = row_offset + k - 1;
                    max_col = col_offset + k - 1;
                    if max_val == 0
                        error('A mátrix szinguláris.');
                    end
                    if max_col ~= k
                        temp = Ab(:, k);
                        Ab(:, k) = Ab(:, max_col);
                        Ab(:, max_col) = temp;
                    end
            end

            if max_row ~= k
                temp = Ab(k, :);
                Ab(k, :) = Ab(max_row, :);
                Ab(max_row, :) = temp;
            end

            for i = k + 1:m
                factor = Ab(i, k) / Ab(k, k);
                Ab(i, :) = Ab(i, :) - factor * Ab(k, :);
            end

            if verbose2
                fprintf('A(%d):', k);
                disp(Ab);
            end
        end

        % Visszahelyettesítés
        x = zeros(n, 1);
        for i = n:-1:1
            x(i) = (Ab(i, end) - Ab(i, i + 1:n) * x(i + 1:n)) / Ab(i, i);
        end

        X_temp(:, j) = x;
    end

    X = X_temp;
end


% PÉLDA HASZNÁLAT!
% A mátrix és b vektor definiálása
A = [2,3,1 ; 4,1,2; 3,2,3];
b = [1, 2, 3; 2, 5, 7; 3, 4, 8];

% Gauss-elimináció végrehajtása, teljes főelem-kiválasztással
x = gaussel2_lu_function(A, b, false, false, "full");

% Megoldás kiírása
disp("Összesen "+size(x, 2)+" megoldásvektor van.");
if size(x, 2) == 1
    disp('A megoldásvektor:');
end
if size(x, 2) >= 2
    disp('A megoldásvektorok:')
end
disp(x);
