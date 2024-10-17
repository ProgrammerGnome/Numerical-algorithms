function H = householder_function(P, P_prime)
    % Ellenőrizzük, hogy a P és P_prime azonos méretű-e
    if length(P) ~= length(P_prime)
        error('P és P_prime méretének egyeznie kell!');
    end
    
    % A tükrözési vektor kiszámítása
    u = P - P_prime;
    
    % Sigma kiszámítása, figyelembe véve az előjelet a numerikus stabilitás érdekében
    sigma = norm(u);
    if u(1) < 0
        sigma = -sigma;
    end
    
    % Normalizált tükrözési vektor
    v = u + sigma * [1; zeros(length(u) - 1, 1)];
    v = v / norm(v);
    
    % Householder mátrix kiszámítása
    H = eye(length(P)) - 2 * (v * v');
end

% Példa meghívás a Householder transzformáció meghatározásához
P = [1; 2; 3];
P_prime = [4; 5; 6];
H = householder_function(P, P_prime);

% Householder-transzformáció mátrix kiírása
disp('A Householder-transzformáció mátrixa:');
disp(H);
