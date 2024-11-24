function x_star = intfel_function(func_str, a, b, n, epsilon)
    % intfel - Intervallumfelezési módszer egy függvény zérushelyének közelítésére
    %
    % Bemenő paraméterek:
    %   func_str - karakteres változóként megadott függvény, amelynek zérushelyét keressük (pl. 'x^2 - 4')
    %   a, b - intervallum kezdő és végpontja
    %   n - maximális lépésszám
    %   epsilon - pontossági elvárás (opcionális)
    %
    % Kimenet:
    %   x_star - zérushely közelítése az adott pontosságig vagy lépésszámig

    % Függvény kiértékelése karakterláncból
    f = @(x) eval(func_str);

    % Ellenőrizni, hogy f(a) és f(b) előjelei eltérnek-e
    if f(a) * f(b) >= 0
        error('Az intervallum nem megfelelő, adj meg egy olyan intervallumot, ahol a függvény különböző előjelű az intervallum végpontjain!');
    end

    % Intervallumfelezési ciklus
    for i = 1:n
        % Középpont kiszámítása
        x_star = (a + b) / 2;
        fx_star = f(x_star);

        % Hibabecslés elvégzése
        if abs(fx_star) < epsilon
            fprintf('A zérushely megközelítve az elvárt pontossággal.\n');
            return;
        end

        % Intervallum csökkentése a gyök helyének megfelelően
        if f(a) * fx_star < 0
            b = x_star;
        else
            a = x_star;
        end

        % Intervallumhossz ellenőrzése
        if abs(b - a) < epsilon
            fprintf('Az intervallum elég kicsi, az iteráció leáll.\n');
            return;
        end
    end

    % Ha a maximális lépésszámot elérte
    fprintf('A maximális lépésszám elérve. A közelítés: %.10f\n', x_star);
end



% PÉLDA FÜGGVÉNYHÍVÁS!

% A függvény karakterláncként
func_str = 'x^3 - 4*x + 2';

% Kezdő intervallum
a = 1;
b = 3;

% Maximális lépésszám
n = 100;

% Pontossági elvárás
epsilon = 1e-6;

% A zérushely közelítésének kiszámítása
x_star = intfel_function(func_str, a, b, n, epsilon);

% Eredmény kiírása
fprintf('A közelítő gyök értéke: %.10f\n', x_star);
