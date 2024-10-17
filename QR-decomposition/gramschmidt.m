function [Q, R] = gramschmidt_function(A)
    % QR-felbontás Gram-Schmidt ortogonalizációval
    % Bemenet:
    %   A - Négyzetes mátrix
    % Kimenetek:
    %   Q - Ortogonális mátrix
    %   R - Felső háromszög mátrix, melyekre A = Q * R

    % Ellenőrzés: a mátrix oszlopai lineárisan függetlenek-e
    if rank(A) < size(A, 2)
        error('A mátrix oszlopai lineárisan függetlenek kell legyenek a QR-felbontáshoz.');
    end

    % Mátrix méretének lekérdezése
    [m, n] = size(A);

    % Inicializálás
    Q = zeros(m, n);
    R = zeros(n, n);

    % Gram-Schmidt eljárás
    for j = 1:n
        v = A(:, j);
        for i = 1:j-1
            R(i, j) = Q(:, i)' * A(:, j);
            v = v - R(i, j) * Q(:, i);
        end
        R(j, j) = norm(v);
        Q(:, j) = v / R(j, j);
    end
end

% A mátrix definiálása
A = [1, 2, 4; 3, 8, 14; 2, 6, 13];

% QR-felbontás Gram-Schmidt ortogonalizációval
[Q, R] = gramschmidt_function(A);

% Eredmények kiírása
disp('Q mátrix:');
disp(Q);
disp('R mátrix:');
disp(R);
