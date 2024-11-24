function lagrangeip_function(x, y, abrazolni)
    % Lagrange interpolációs polinom számítása és opcionális ábrázolása
    % x: alappontok
    % y: hozzájuk tartozó függvényértékek
    % abrazolni: logikai változó, amely szabályozza az ábrázolást (true/false)

    % Ellenőrizzük, hogy x és y ugyanannyi elemet tartalmaz-e
    if length(x) ~= length(y)
        error('Az x és y vektoroknak azonos hosszúságúnak kell lenniük!');
    end

    % Alapvető paraméterek
    n = length(x);  % Alappontok száma
    min_x = min(x);
    max_x = max(x);
    
    % Interpolációs polinom összegzése
    osszeg = 0;  % Polinom tárolása
    for k = 1:n
        Lk = 1;  % Készítjük a k-adik Lagrange polinomot
        for l = 1:n
            if l ~= k
                % Lk(x) = szorzat (x - xl) / (xk - xl)
                Lk = conv(Lk, [1, -x(l)]) / (x(k) - x(l));
            end
        end
        % Hozzáadjuk a polinomot a megfelelő súlyozással
        osszeg = osszeg + Lk * y(k);
    end
    
    % Az interpolációs polinom együtthatói
    F = osszeg;

    % Kiírás, ha nincs ábrázolás
    if ~abrazolni
        disp('Interpolációs polinom együtthatói:');
        disp(F);
        return;
    end

    % Ha ábrázolni kell
    % x tengely pontjai az ábrázoláshoz
    px = linspace(min_x, max_x, 1000);
    py = polyval(F, px);  % Polinom értékeinek számítása
    
    % Ábrázolás
    plot(x, y, 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Alappontok'); % Alappontok
    hold on;
    plot(px, py, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Interpolációs polinom'); % Polinom
    xlabel('x');
    ylabel('y');
    title('Lagrange interpoláció');
    legend('show');
    grid on;
    hold off;
end



% PÉLDA FÜGGVÉNYHÍVÁS!

% Alappontok és függvényértékek
x = [1, 2, 3, 4];
y = [2, 4, 3, 7];

% Ábrázolás tiltása
abrazolni = false;

% Függvény meghívása
lagrangeip_function(x, y, abrazolni);
