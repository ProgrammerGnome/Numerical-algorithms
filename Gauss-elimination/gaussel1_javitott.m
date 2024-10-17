function X = gaussel2_function(A, B, verbose, lu_decompose, pivot_type)
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
    if nargin < 4
        error('Legalább 4 bemeneti paraméter szükséges.');
    end
    if nargin < 3
        verbose = false;  % Köztes lépések kiírása alapértelmezés szerint hamis
    end
    if nargin < 4
        lu_decompose = false;  % LU felbontás kiírása alapértelmezés szerint hamis
    end
    if nargin < 5
        pivot_type = 'partial'; % Alapértelmezett: részleges főelemkiválasztás
        disp("Nem lett megadva a főelem kiválasztásának módszere, folytatás az alapértelmezett módszerrel.");
    end
    % Pivot típus ellenőrzése és megfelelő üzenet kiírása (csak egyszer)
    persistent pivot_type_displayed;
    if isempty(pivot_type_displayed)
        pivot_type_displayed = false;
    end
    if strcmp(pivot_type, 'full') && ~pivot_type_displayed
        disp("A teljes főelem kiválasztás módszerét választotta.");
        pivot_type_displayed = true;
    elseif strcmp(pivot_type, 'partial') && ~pivot_type_displayed
        disp("A részleges főelem kiválasztás módszerét választotta.");
        pivot_type_displayed = true;
    elseif ~strcmp(pivot_type, 'partial') && ~strcmp(pivot_type, 'full')
        error('Ismeretlen pivot típus. Használja a "partial" vagy "full" értéket.');
    end
    
    % Méret ellenőrzés
    [m, n] = size(A);
    [mb, nb] = size(B);
    if m ~= mb
        error('A mátrix és a jobboldali vektor(ok) mérete nem egyezik.');
    end

    % Az összes megoldás tárolására szolgáló mátrix
    X_temp = zeros(n, nb); % Ideiglenes tárolás
    L_global = eye(m); % Kezdeti L mátrix az LU felbontáshoz
    U_global = A; % Kezdeti U mátrix az LU felbontáshoz

    % Minden jobboldali vektorhoz külön végrehajtjuk a Gauss-eliminációt párhuzamosan
    parfor j = 1:nb
        b = B(:, j);
        Ab = [A b];
        local_pivot_type = pivot_type; % Pivot típus másolat minden iterációhoz
        L_local = eye(m); % Lokális L mátrix minden iterációhoz
        U_local = A; % Lokális U mátrix minden iterációhoz

        if verbose
            disp('Az egyenletrendszerből készült mátrix a következő:');
            disp(Ab);
            disp("Kezdjük is el az algoritmus végrehajtását...");
        end

        for k = 1:min(m, n)
            switch local_pivot_type
                case 'partial'
                    % Részleges főelemkiválasztás
                    [max_val, max_row] = max(abs(Ab(k:m, k)));
                    max_row = max_row + k - 1;
                    if max_val == 0
                        % Ha a pivot elem nulla, akkor megpróbálunk teljes főelemkiválasztást
                        disp('A részleges főelemkiválasztás nem lehetséges, megpróbálkozunk a teljes főelemkiválasztással.');
                        local_pivot_type = "full";
                    end
                case 'full'
                    % Teljes főelemkiválasztás
                    [max_val, max_idx] = max(abs(Ab(k:m, k:n)), [], 'all', 'linear');
                    [row_offset, col_offset] = ind2sub([m - k + 1, n - k + 1], max_idx);
                    max_row = row_offset + k - 1;
                    max_col = col_offset + k - 1;
                    if max_val == 0
                        error('A mátrix szinguláris, nincs egyértelmű megoldás.');
                    end
                    % Oszlopcsere
                    if max_col ~= k
                        temp = Ab(:, k);
                        Ab(:, k) = Ab(:, max_col);
                        Ab(:, max_col) = temp;
                    end
                otherwise
                    error('Ismeretlen pivot típus. Használja a "partial" vagy "full" értéket.');
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

            % Köztes mátrixok kiírása
            if verbose
                fprintf('A(%d):', k);
                disp(Ab);
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

% A mátrix és b vektor definiálása
A = [2,3,1 ; 4,1,2; 3,2,3];
b = [1, 2, 3; 2, 5, 7; 3, 4, 8];

% Gauss-elimináció végrehajtása, teljes főelem-kiválasztással
x = gaussel2_function(A, b, true, true, "full");

% Megoldás kiírása
disp("Összesen "+size(x, 2)+" megoldásvektor van.");
if size(x, 2) == 1
    disp('A megoldásvektor:');
end
if size(x, 2) >= 2
    disp('A megoldásvektorok:')
end
disp(x);



disp("Az LU felbontás pedig:");
function [L, U] = lu_decomposition(A, verbose)
    % LU_DECOMPOSITION LU felbontás az A mátrixra L és U mátrixok szorzataként.
    % Bemenetek:
    %   A - Az egyenletrendszer mátrixa.
    %   verbose - Köztes lépések kiírását vezérli.
    %
    % Visszatérés:
    %   L - Alsó háromszögmátrix egységnyi átlóval.
    %   U - Felső háromszögmátrix.

    if nargin < 2
        verbose = false;  % Köztes lépések kiírása alapértelmezés szerint hamis
    end

    % Méret ellenőrzés
    [m, n] = size(A);
    if m ~= n
        error('A mátrixnak négyzetesnek kell lennie az LU felbontáshoz.');
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
end
[L, U] = lu_decomposition(A, true);

% L és U mátrixok kiírása
disp('Az L mátrix:');
disp(L);
disp('Az U mátrix:');
disp(U);
