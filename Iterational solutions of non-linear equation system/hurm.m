function x_star = hurm_function(func_str, a, b, n)
    % hurm - Húrmódszer egy függvény zérushelyének közelítésére
    %
    % Bemenő paraméterek:
    %   func_str - karakteres változóként megadott függvény, amelynek zérushelyét keressük (pl. 'x^3 - 4*x + 2')
    %   a, b - intervallum kezdő és végpontja
    %   n - maximális lépésszám
    %
    % Kimenet:
    %   x_star - zérushely közelítése az adott lépésszámig

    % Függvény definiálása karakterláncból
    f = str2func(['@(x)', func_str]);

    % Ellenőrizni, hogy f(a) és f(b) előjelei eltérnek-e
    if f(a) * f(b) >= 0
        error('Az intervallum nem megfelelő, adj meg egy olyan intervallumot, ahol a függvény különböző előjelű az intervallum végpontjain!');
    end

    % Megkérdezzük a felhasználót, hogy rajzoljon-e ábrát
    choice = input('Szeretne ábrát rajzolni? (igen/nem): ', 's');
    draw_plot = strcmpi(choice, 'igen');

    % Ha a felhasználó igennel válaszol, előkészítjük az ábrát
    if draw_plot
        figure;
        hold on;
        fplot(f, [a, b], 'k-'); % Függvény ábrázolása
        xlabel('x');
        ylabel('f(x)');
        title('Húrmódszer gyökközelítés');
        grid on;
    end

    % Húrmódszer iterációk
    for i = 1:n
        % Húr által meghatározott pont kiszámítása
        x_star = b - f(b) * (b - a) / (f(b) - f(a));

        % Ábrázolás a húrral, ha a felhasználó ezt kérte
        if draw_plot
            plot([a, b], [f(a), f(b)], 'b--o');
            plot(x_star, f(x_star), 'ro');
        end

        % Hibakritérium ellenőrzése
        if abs(f(x_star)) < 1e-6
            fprintf('A zérushely megközelítve az elvárt pontossággal.\n');
            break;
        end

        % Intervallum frissítése
        if f(a) * f(x_star) < 0
            b = x_star;
        else
            a = x_star;
        end
    end

    % Ha ábrázoltunk, lezárjuk az ábrát
    if draw_plot
        hold off;
    end

    fprintf('A közelítő gyök értéke: %.10f\n', x_star);
end



% PÉLDA FÜGGVÉNYHÍVÁS!

% Függvény karakterláncként
func_str = 'x^3 - 4*x + 2';

% Kezdő intervallum
a = 1;
b = 3;

% Maximális lépésszám
n = 100;

% A zérushely közelítésének kiszámítása
x_star = hurm_function(func_str, a, b, n);
