function result = fl1(vec)
    % Ellenőrizzük, hogy a bemeneti vektor csak 0-t és 1-et tartalmaz-e (kivéve az utolsó elemet)!
    if any(vec(1:end-1) ~= 0 & vec(1:end-1) ~= 1)
        error('A mantissza jegyeinek 0 vagy 1 értékeket kell tartalmaznia.');
    end

    % A mantissza első eleme az előjelbit
    sign_bit = vec(1);
    mantissa = vec(2:end-1);  % A mantissza többi része (az első bit az előjel)

    % A karakterisztika az utolsó elem a vektorban
    exponent = vec(end);

    % Ellenőrzés a karakterisztika korlátaira
    % A mantissza hossza a megadott vektor hosszánál egy bittel rövidebb
    t = length(vec) - 2;  % Mantissza hossza (a karakterisztika és az előjelbit nélkül)
    
    % Megengedett határok a karakterisztika számára
    k_min = -t; % Például, hogy a karakterisztika minimuma -t legyen
    k_max = t;  % Maximum karakterisztika érték

    % Ellenőrizzük, hogy az exponent a megadott határok között van-e
    if exponent < k_min || exponent > k_max
        error('A karakterisztika értéke kívül esik a megengedett határokon.');
    end

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



% FÜGGVÉNYHÍVÁS!
vec = [0 1 1 0 0 1 0 1 0 2];  % Ez egy példavektor
val = fl1(vec);
disp('A gépi szám értéke:');
disp(val);
