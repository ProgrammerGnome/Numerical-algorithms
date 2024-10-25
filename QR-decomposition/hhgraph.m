function hhgraph()
    % Pontok terminálból való bekérése
    disp('Adja meg az első pont koordinátáit (a):');
    a = input('Formátum [x y z]: ');
    disp('Adja meg a második pont koordinátáit (b):');
    b = input('Formátum [x y z]: ');

    % Householder vektor kiszámítása
    v = b - a;
    norm_v = norm(v);
    u = v / norm_v;  % Normalizált Householder vektor

    % Householder mátrix meghívása
    H = householder_function(a, b);

    % További pont bekérése
    disp('Adjon meg egy új pontot a transzformációhoz:');
    new_point = input('Formátum [x y z]: ');

    % Transzformált pont kiszámítása
    transformed_point = H * new_point';

    % Grafikus kirajzolás
    figure;
    hold on;
    axis equal;
    grid on;
    view(3);  % 3D nézet beállítása

    % Hipersík megjelenítése
    [X, Y] = meshgrid(linspace(-10, 10, 40));  % Sík X és Y koordinátái
    Z = (-u(1) * X - u(2) * Y) / u(3);  % Sík Z koordinátája
    surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');  % Sík ábrázolása

    % Pontok ábrázolása
    plot3(a(1), a(2), a(3), 'bo', 'MarkerFaceColor', 'b');
    plot3(b(1), b(2), b(3), 'bo', 'MarkerFaceColor', 'b');
    plot3(new_point(1), new_point(2), new_point(3), 'go', 'MarkerFaceColor', 'g');
    plot3(transformed_point(1), transformed_point(2), transformed_point(3), 'ro', 'MarkerFaceColor', 'r');

    % Tengelyek címkézése
    xlabel('X tengely');
    ylabel('Y tengely');
    zlabel('Z tengely');

    % Címkék hozzáadása
    legend('Hipersík', 'Eredeti pont (a)', 'Új pont (b)', 'Tetszőleges pont', 'Tetszőleges pont Householder transzformáltja');
    hold off;
end



function H = householder_function(a, b)
    % Az egész feladat a tankönyv (példatár) alapján készült.
    disp("Ön a következő vektorokat adta meg: ");
    disp(a);
    disp(b);

    if ((norm(a, 2) ~= norm(b, 2)) || (length(a) ~= length(b)))
        error('A vektorok dimenziói és/vagy normái nem egyeznek!');
    end
    
    e_vector = zeros(length(a), 1);
    e_vector(1) = 1;
    
    sigma = -sign(a(1))*norm(a, 2);
    v_denominator = a-sigma*e_vector;
    v_nominator = norm(v_denominator, 2);
    v = v_denominator/v_nominator;
    
    H = eye(length(v)) - 2 * (v * v');
end


% A konzolos bekérés szándékos!
% Az alábbi adatokkal lehet pl. gyorsan tesztelni:
% Jegyzetből: 32.o./63., megoldás a 84.oldalon.
% a = [2 1 1]
% b = [-sqrt(6) 0 0]
% P = tetszőleges
