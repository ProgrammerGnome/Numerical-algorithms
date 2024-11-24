function integral = numint_function(integrandus, a, b, n, formula)
    % Klasszikus kvadratúra formulák alkalmazása numerikus integrációhoz
    % Bemenet:
    % - integrandus: az integrálandó függvény stringként, pl. 'sin(x)'
    % - a, b: az integrálási intervallum végpontjai
    % - n: az osztópontok száma
    % - formula: a kvadratúra formula típusa ('teglalap', 'trapez', 'simpson')
    % Kimenet:
    % - integral: a numerikus integrál eredménye
    
    % Ellenőrzések
    if n < 1
        error('Az osztópontok száma legalább 1 kell, hogy legyen.');
    end
    if ~ismember(formula, {'teglalap', 'trapez', 'simpson'})
        error('A formula típusa csak ''teglalap'', ''trapez'' vagy ''simpson'' lehet.');
    end
    
    % Az x értékek osztása
    x = linspace(a, b, n+1); % n szegmens => n+1 osztópont
    h = (b - a) / n; % Az intervallum szélessége

    % Az integrálandó függvény értékeinek számítása
    f = @(x) eval(integrandus); % Függvény értékelése
    y = arrayfun(f, x); % f értékei az osztópontokban

    % Numerikus integrálás a választott formula alapján
    switch formula
        case 'teglalap'
            % Bal oldali téglalap formula
            integral = h * sum(y(1:end-1));
        
        case 'trapez'
            % Trapéz formula
            integral = h * (sum(y) - 0.5 * (y(1) + y(end)));
        
        case 'simpson'
            % Simpson formula (n páros kell legyen)
            if mod(n, 2) ~= 0
                error('A Simpson formulához az osztópontok száma páros kell legyen.');
            end
            integral = (h / 3) * (y(1) + y(end) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)));
    end
end



% PÉLDA FÜGGVÉNYHÍVÁS!!!

disp('Téglalap módszer:');
result = numint_function('sin(x)', 0, pi, 10, 'teglalap');
disp(result); % Eredmény: közelítő integrál [0, pi] intervallumon

disp('Trapéz módszer:');
result = numint_function('x^2', 0, 2, 10, 'trapez');
disp(result); % Eredmény: közelítő integrál [0, 2] intervallumon

disp('Simpson módszer:');
result = numint_function('x^3', 0, 1, 10, 'simpson');
disp(result); % Eredmény: közelítő integrál [0, 1] intervallumon
