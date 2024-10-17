function [Q, R] = hhalg_function(A)
    % Ellenőrizzük, hogy A négyzetes mátrix-e
    [m, n] = size(A);
    if m ~= n
        error('A mátrixnak négyzetesnek kell lennie!');
    end

    Q = eye(n);
    R = A;

    for k = 1:n-1
        % Householder transzformáció létrehozása a k-adik oszlopban
        x = R(k:n, k);
        e = eye(length(x), 1);
        sigma = norm(x);
        if x(1) < 0
            sigma = -sigma;
        end
        u = x + sigma * e;
        u = u / norm(u);
        Hk = eye(n);
        Hk(k:n, k:n) = eye(length(x)) - 2 * (u * u');

        % R és Q frissítése
        R = Hk * R;
        Q = Q * Hk';
    end

    % Az utolsó lépésben, ha szükséges, normalizáljuk a végleges R mátrixot
    for j = 1:n
        if R(j, j) < 0
            R(j, j:n) = -R(j, j:n);
            Q(:, j) = -Q(:, j);
        end
    end
end

% Definiáljunk egy tesztmátrixot
A = [12 -51 4; 6 167 -68; -4 24 -41];

% QR-felbontás elvégzése
[Q, R] = hhalg_function(A);

% Kiíratás az eredményekről
disp('Q mátrix:');
disp(Q);
disp('R mátrix:');
disp(R);
disp('Ellenőrzés, hogy A = Q * R:');
disp(Q * R);
