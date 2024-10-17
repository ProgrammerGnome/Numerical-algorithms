function A_inv = gaussel3_function(A)
    % GAUSSEL3 Mátrix inverzének meghatározására.
    % Bemenetek:
    %   A - Az invertálandó mátrix.
    %   verbose - Köztes lépések kiírását vezérli.
    %   pivot_type - 'partial' (részleges) vagy 'full' (teljes) főelemkiválasztás.
    %
    % Visszatérés:
    %   A_inv - Az A mátrix inverze.

    disp("A megadott mátrix a következőképp néz ki:");
    disp(A);

    % Bemenetek ellenőrzése
    verbose = false;

    % Méret ellenőrzés
    [m, n] = size(A);
    if m ~= n
        error('A mátrixnak négyzetesnek kell lennie az inverz meghatározásához.');
    end

    % Determináns kiszámítása
    det_A = det(A);
    if det_A == 0
        error('A mátrix szinguláris, nincs inverze.');
    end
    disp(['A mátrix determinánsa: ', num2str(det_A)]);

    % Az egységmátrix definiálása
    I = eye(n);

    % Inverz kiszámítása minden oszlopra külön
    A_inv = zeros(n);
    for j = 1:n
        e = I(:, j);
        % Gauss elimináció az A*X=I egyenletrendszerre az adott oszlopra
        x = gaussel2_function(A, e, verbose);
        A_inv(:, j) = x;
    end
    
end

% A mátrix definiálása
A = [2, 1, -1; 1, 3, 2; 1, -1, 2];

% Mátrix inverzének meghatározása, teljes főelemkiválasztással
A_inv = gaussel3_function(A);

% Inverz kiírása
disp('A mátrix inverze:');
disp(A_inv);





% AZ ELŐZŐ FELADATBÓL MÁSOLT KÓD LENNE... de ez le van butítva!

function X = gaussel2_function(A, B, verbose)
    % GAUSSEL2 Gauss elimináció az A*X=B lineáris egyenletrendszerre, részleges vagy teljes főelemkiválasztással.
    % Bemenetek:
    %   A - Az egyenletrendszer mátrixa.
    %   B - Jobboldali vektor(ok).
    %   verbose - Köztes lépések kiírását vezérli.
    %   lu_decompose - LU felbontás és Li mátrixok kiírása.
    %   pivot_type - 'partial' (részleges) vagy 'full' (teljes) főelemkiválasztás.
    %
    % Visszatérés:
    %   X - A megoldásvektor(ok).

    % Bemenetek ellenőrzése
    if nargin < 3
        error('Legalább 4 bemeneti paraméter szükséges.');
    end
    
    % Méret ellenőrzés
    [m, n] = size(A);
    [mb, nb] = size(B);
    if m ~= mb
        error('A mátrix és a jobboldali vektor(ok) mérete nem egyezik.');
    end

    % Az összes megoldás tárolására szolgáló mátrix
    X_temp = zeros(n, nb); % Ideiglenes tárolás

    % Minden jobboldali vektorhoz külön végrehajtjuk a Gauss-eliminációt párhuzamosan
    parfor j = 1:nb
        b = B(:, j);
        Ab = [A b];

        if verbose
            disp('Az egyenletrendszerből készült mátrix a következő:');
            disp(Ab);
            disp("Kezdjük is el az algoritmus végrehajtását...");
        end

        for k = 1:min(m, n)
            % Részleges főelemkiválasztás
            [max_val, max_row] = max(abs(Ab(k:m, k)));
            max_row = max_row + k - 1;
            if max_val == 0
                error('A mátrix szinguláris, nincs egyértelmű megoldás.');
            end

            % Sorcsere, ha szükséges
            if max_row ~= k
                temp = Ab(k, :);
                Ab(k, :) = Ab(max_row, :);
                Ab(max_row, :) = temp;
            end

            % Elimináció
            for i = k + 1:m
                factor = Ab(i, k) / Ab(k, k);
                Ab(i, :) = Ab(i, :) - factor * Ab(k, :);
            end
        end

        % Visszahelyettesítés
        x = zeros(n, 1);
        for i = n:-1:1
            x(i) = (Ab(i, end) - Ab(i, i + 1:n) * x(i + 1:n)) / Ab(i, i);
        end

        % A megoldás tárolása a helyes sorrend biztosításával
        X_temp(:, j) = x;
    end

    % A megoldások átmásolása az eredeti X mátrixba
    X = X_temp;

end
