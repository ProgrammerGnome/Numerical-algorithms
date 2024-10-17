function fl3(x, t, k1, k2)
    % x:  Tízes számrendszerbeli tört szám
    % t:  Mantissza hossza
    % k1: Karakterisztika minimum értéke
    % k2: Karakterisztika maximum értéke

    % Előjel ellenőrzés
    if x < 0
        sign_bit = '-'; % Negatív szám esetén
        x = abs(x);     % Az abszolút értékkel dolgozunk
    else
        sign_bit = '';  % Pozitív szám esetén nincs előjel
    end

    % Normálás előkészítése
    if x == 0
        fprintf('A szám nulla.\n');
        return;
    end

    % Normálás: bináris számjegyek gyűjtése
    whole_part = floor(x); % Egész rész
    fraction_part = x - whole_part; % Tört rész

    % Bináris konverzió az egész részre
    g = [];
    if whole_part == 0
        g = [0];
    else
        while (whole_part > 0)
            b = rem(whole_part, 2);
            whole_part = floor(whole_part / 2);
            g = [b g];
        end
    end

    % Bináris konverzió a tört részre
    fractional_bits = [];
    max_fraction_bits = t; % A törtrész maximális hossza mostantól a mantissza hossza

    while (fraction_part > 0 && length(fractional_bits) < max_fraction_bits)
        fraction_part = fraction_part * 2;
        if fraction_part >= 1
            fractional_bits = [fractional_bits 1];
            fraction_part = fraction_part - 1;
        else
            fractional_bits = [fractional_bits 0];
        end
    end

    % Bináris szám normálása
    if g(1) == 0
        % Ha az egész rész 0, akkor a normálás a törtrész alapján történik
        shift = 0;
        while g(1) == 0
            g(1) = []; % Elhagyjuk a vezető 0-t
            shift = shift + 1;
        end
        e = -shift; % Karakterisztika változás
    else
        e = length(g) - 1; % Karakterisztika az egészrész hossza alapján
    end

    % Ellenőrizzük, hogy a karakterisztika a k1 és k2 közötti tartományba esik-e
    if e < k1 || e > k2
        fprintf('A szám nem ábrázolható a megadott karakterisztika intervallumon.\n');
        return;
    end

    % Mantissza hossza szabályozása
    mantissa = [g fractional_bits]; % Egész és tört rész összefűzése
    mantissa = mantissa(1:t); % A mantissza hossza t bitre korlátozva

    % Eredmény megjelenítése
    fprintf('A normalizált eredmény: %s1.', sign_bit);
    fprintf('%d', mantissa(2:end)); % Az első bit már 1, azt nem írjuk ki még egyszer
    fprintf(' * 2^%d\n', e); % Kiírjuk a karakterisztikát
end



% FÜGGVÉNYHÍVÁS!
x = 3.17;  % Tízes számrendszerbeli pozitív/negatív/egész/tört szám

t = 7;     % Mantissza hossza
k1 = -3;   % Karakterisztika alsó korlátja
k2 = 3;    % Karakterisztika felső korlátja

fl3(x, t, k1, k2); % Függvény hívása
