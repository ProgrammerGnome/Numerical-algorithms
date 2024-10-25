function H = householder_function(a, b)

    % Az egész feladat a tankönyv (példatár) alapján készült.
    disp("Ön a következő vektorokat adta meg: ");
    disp(a);
    disp(b);

    if ((norm(a, 2) ~= norm(b, 2)) || (length(a) ~= length(b)))
        error('A vektorok dimenziói és/vagy normái nem egyeznek!');
    end
    
    e_vector = zeros(length(a), 1);
    e_vector(1) = 1;
    
    sigma = -sign(a(1))*norm(a, 2);
    v_denominator = a-sigma*e_vector;
    v_nominator = norm(v_denominator, 2);
    v = v_denominator/v_nominator;
    
    H = eye(length(v)) - 2 * (v * v');
end

% PÉLDA HASZNÁLAT! (Jegyzetből: 32.o./63., megoldás a 84.oldalon.)
a = [2; 1; 1];
b = [-sqrt(6); 0; 0];
H = householder_function(a, b);

disp('A Householder-transzformáció mátrixa:');
disp(H);
