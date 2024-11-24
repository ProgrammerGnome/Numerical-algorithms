function altalanosInverz = geninv_function(A)
    % Általánosított inverz kiszámítása rangfaktorizációval
    % Bemenet:
    % - A: tetszőleges mátrix
    % Kimenet:
    % - altalanosInverz: A mátrix általánosított inverze

    % Ellenőrizzük a mátrix rangját
    r = rank(A);

    if r == min(size(A)) % Teljesrangú mátrix
        if size(A, 1) == size(A, 2)
            % Négyzetes, teljesrangú mátrix
            altalanosInverz = inv(A);
        elseif size(A, 1) > size(A, 2)
            % Túlhatározott mátrix (sorok száma > oszlopok száma)
            altalanosInverz = (A' * A) \ A';
        else
            % Alulhatározott mátrix (oszlopok száma > sorok száma)
            altalanosInverz = A' / (A * A');
        end
    else
        % Ranghiányos mátrix: Pseudo-inverz számítása
        altalanosInverz = pinv(A);
    end
end



% PÉLDA FÜGGVÉNYHÍVÁS különböző esetekre

disp('Általánosított inverz:');
disp(geninv_function([1 0 2 -1; 2 1 5 0; 3 0 6 -3]));

disp('Négyzetes, teljesrangú mátrix:');
A = [4, 7; 2, 6];
disp(geninv_function(A));

disp('Túlhatározott mátrix:');
A = [1, 2; 3, 4; 5, 6];
disp(geninv_function(A));

disp('Alulhatározott mátrix:');
A = [1, 3, 5; 2, 4, 6];
disp(geninv_function(A));

disp('Ranghiányos mátrix:');
A = [1, 2; 2, 4];
disp(geninv_function(A));
