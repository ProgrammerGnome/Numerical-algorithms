function result = fl1(vec)
    % Ellenőrizzük, hogy a bemeneti vektor tartalmaz-e csak 0-t és 1-et (kivéve az utolsó elemet)
    if any(vec(1:end-1) ~= 0 & vec(1:end-1) ~= 1)
        error('A mantissza jegyeinek 0 vagy 1 értékeket kell tartalmaznia.');
    end

    % A mantissza első eleme az előjelbit
    sign_bit = vec(1);
    mantissa = vec(2:end-1);  % A mantissza többi része (az első bit az előjel)

    % A karakterisztika az utolsó elem a vektorban
    exponent = vec(end);

    % A mantissza bináris értékének kiszámítása (2-es számrendszerből való átszámítás)
    mantissa_value = 0;
    for i = 1:length(mantissa)
        mantissa_value = mantissa_value + mantissa(i) * 2^(-i);
    end

    % Előjel alkalmazása
    if sign_bit == 1
        mantissa_value = -mantissa_value;
    end

    % A gépiszám kiszámítása a karakterisztika alapján
    result = mantissa_value * 2^exponent;
end


function [num_elements, M_inf, eps0, eps1] = fl2(t, k1, k2)
    % Ellenőrizzük a bemeneti paramétereket
    if ~isscalar(t) || ~isscalar(k1) || ~isscalar(k2) || t <= 0 || k1 >= k2
        error('Hibás bemeneti paraméterek. t > 0 és k1 < k2 kell, hogy legyenek.');
    end

    % A gépi számhalmaz elemeinek kiszámítása
    num_elements = 2 * (2^(t - 1)) * (k2 - k1 + 1);

    % Mantissza hossza: t+1 bit (az előjel bittel együtt)
    % Készítsünk egy vektort, amely a maximális mantisszát ábrázolja (csupa 1-es bit)
    mantissa_max = [0 ones(1, t)];

    % 1. Nevezetes elem: M∞ (legnagyobb pozitív szám)
    M_inf = fl1([mantissa_max k2]);

    % 2. Nevezetes elem: ε0 (legkisebb pozitív szám)
    mantissa_min = [0 1 zeros(1, t-1)];  % Legkisebb normalizált mantissza
    eps0 = fl1([mantissa_min k1]);  % ε0 a legkisebb normalizált pozitív szám

    % 3. Nevezetes elem: ε1 (egynél nagyobb legkisebb gépi szám és egy különbsége)
    mantissa_near_one = [0 1 zeros(1, t-1) 1];  % A legkisebb mantissza, ami nagyobb 1-nél
    eps1 = 2*(fl1([mantissa_near_one 1]) - fl1([mantissa_min 1]));  % Az egy és a legkisebb gépi szám közötti különbség

    % Eredmények kiírása
    fprintf('A gépi számhalmaz elemszáma: %d\n', num_elements);
    fprintf('M∞ (legnagyobb pozitív szám): %.10f\n', M_inf);
    fprintf('ε0 (legkisebb pozitív normalizált szám): %.10f\n', eps0);
    fprintf('ε1 (legkisebb pozitív denormalizált szám): %.10f\n', eps1);
end



% FÜGGVÉNYHÍVÁS!
t = 7;
k1 = -2;
k2 = 5;
[num_elements, M_inf, eps0, eps1] = fl2(t, k1, k2);
