function x_star = newt_function(func_str, x0, n)
    % newt - Newton-módszer egy függvény zérushelyének közelítésére numerikus deriválással
    %
    % Bemenő paraméterek:
    %   func_str - karakteres változóként megadott függvény, amelynek zérushelyét keressük (pl. 'x^2 - 4')
    %   x0 - kiindulási pont az iterációhoz
    %   n - maximális lépésszám
    %
    % Kimenet:
    %   x_star - zérushely közelítése az adott lépésszámig

    % Függvény definiálása karakterláncból
    f = str2func(['@(x)', func_str]);

    % Numerikus deriválás lépésköze
    h = 1e-6;

    % Newton-módszer iterációk
    x_star = x0; % Kiindulási pont
    for i = 1:n
        % Függvényérték számítása az aktuális pontban
        fx = f(x_star);
        
        % Numerikus derivált közelítése

        % A diff() szimbolikus függvényhez Symbolic Math Toolbox kéne...
        % f_sym = str2sym(f);
        % df_sym = diff(f_sym, x);
        % dfx = double(subs(df_sym, x, x_star));

        dfx = (f(x_star + h) - f(x_star - h)) / (2 * h);

        % Ellenőrzés a derivált nulla elkerülésére
        if abs(dfx) < 1e-12
            error('A derivált értéke túl közel van a nullához az x = %.10f pontban, a Newton-módszer nem folytatható.', x_star);
        end

        % Következő iterációs pont kiszámítása
        x_star = x_star - fx / dfx;

        % Hibakritérium ellenőrzése
        if abs(fx) < 1e-6
            fprintf('A zérushely megközelítve az elvárt pontossággal.\n');
            return;
        end
    end

    fprintf('A maximális lépésszám elérve. A közelítés: %.10f\n', x_star);
end



% PÉLDA FÜGGVÉNYHÍVÁS!

% Függvény karakterláncként
func_str = 'x^3 - 4*x + 2';

% Kiindulási pont
x0 = 3;

% Maximális lépésszám
n = 100;

% A zérushely közelítésének kiszámítása
x_star = newt_function(func_str, x0, n);

% Eredmény kiírása
fprintf('A közelítő gyök értéke: %.10f\n', x_star);
