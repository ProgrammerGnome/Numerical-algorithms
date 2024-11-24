function bsplinedraw_function(knots, l, k_values)
    % B-spline rajzolása adott paraméterekkel
    % knots: csomópontok tömbje
    % l: a B-spline fokszáma
    % k_values: az indexek, amelyeket meg akarunk rajzolni

    if length(knots) < l + 2
        error('A csomópontok tömbje túl kicsi a megadott fokhoz!');
    end

    % Rajzolási tartomány
    x = linspace(min(knots), max(knots), 1000);

    figure;
    hold on;
    for k = k_values
        % Számoljuk ki a B-spline értékeket a tartományban
        y = arrayfun(@(xi) bspline_recursive(knots, l, k, xi), x);

        % Rajzolás
        plot(x, y, 'DisplayName', sprintf('B_{%d,%d}(x)', l, k));
    end

    title(sprintf('B-spline függvények fok: %d', l));
    xlabel('x');
    ylabel('B_{l,k}(x)');
    legend show;
    hold off;
end

function result = bspline_recursive(knots, l, k, x)
    % Rekurzív B-spline számítás
    % knots: csomópontok tömbje
    % l: B-spline fok
    % k: index
    % x: érték, ahol ki akarjuk számolni a függvényt

    % Ellenőrizzük az indexek helyességét
    if k < 1 || k > length(knots) - l - 1
        result = 0; % Nem definiált tartományban
        return;
    end

    % Alap B-spline függvény (l = 0)
    if l == 0
        if knots(k) <= x && x < knots(k+1)
            result = 1;
        else
            result = 0;
        end
        return;
    end

    % Rekurzív összetevők számítása
    denom1 = knots(k+l) - knots(k);
    denom2 = knots(k+l+1) - knots(k+1);

    term1 = 0;
    if denom1 > 0
        term1 = (x - knots(k)) / denom1 * bspline_recursive(knots, l-1, k, x);
    end

    term2 = 0;
    if denom2 > 0
        term2 = (knots(k+l+1) - x) / denom2 * bspline_recursive(knots, l-1, k+1, x);
    end

    % Összegzés
    result = term1 + term2;
end



% PÉLDA FÜGGVÉNYHÍVÁS! (Példa a B-spline rajzolására)

% Csomópontok (egyenletes eloszlás)
knots = [0, 0, 0, 0, 0.5, 1, 1, 1, 1]; % Négyzetes B-spline-hoz megfelelő méretű

% B-spline fokszáma
l = 3;

% Rajzolni kívánt indexek
k_values = 1:5;

% Függvényhívás
bsplinedraw_function(knots, l, k_values);
