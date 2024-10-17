function householder_full()
    % Interaktív rész: grafikus pontbekérés és transzformáció vizualizálása
    figure;
    hold on;
    axis equal;
    grid on;
    
    % Pontok grafikus bekérése
    [x, y] = ginput(2);
    P = [x(1); y(1)];
    P_prime = [x(2); y(2)];
    
    % Householder mátrix meghívása
    H = householder(P, P_prime);
    
    % További pont bekérése és ábrázolása
    [x_new, y_new] = ginput(1);
    new_point = [x_new; y_new];
    
    % Transzformált pont kiszámítása
    transformed_point = H * new_point;
    
    % Pontok és hipersík rajzolása
    plot(x, y, 'bo', 'MarkerFaceColor', 'b');
    line([P(1) P_prime(1)], [P(2) P_prime(2)], 'Color', 'r', 'LineWidth', 2);
    plot(new_point(1), new_point(2), 'go', 'MarkerFaceColor', 'g');
    plot(transformed_point(1), transformed_point(2), 'ro', 'MarkerFaceColor', 'r');
    
    % Címkék hozzáadása
    legend('Eredeti pontok', 'Hipersík', 'Új pont', 'Transzformált pont');
    hold off;

    function H = householder(P, P_prime)
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
end
