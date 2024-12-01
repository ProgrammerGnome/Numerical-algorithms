function transzformacioMatrix = affin2_function(haromszog, kepek)

if nargin == 0
    % Ha nincsenek paraméterek, az adatok bekérése grafikusan történik
    disp('Kérlek, kattints három csúcspont koordinátáira az eredeti háromszöghöz:');
    figure;
    hold on;
    axis equal;
    grid on;
    xlabel('x');
    ylabel('y');
    title('Eredeti háromszög csúcsai');
    [x, y] = ginput(3);
    haromszog = [x, y];

    disp('Kérlek, kattints három csúcspont koordinátáira a transzformált háromszöghöz:');
    figure;
    hold on;
    axis equal;
    grid on;
    xlabel('x');
    ylabel('y');
    title('Transzformált háromszög csúcsai');
    [x, y] = ginput(3);
    kepek = [x, y];
end

% Ellenőrzés: helyes méretű bemeneti adatok
if size(haromszog, 1) ~= 3 || size(kepek, 1) ~= 3 || size(haromszog, 2) ~= 2 || size(kepek, 2) ~= 2
    error('Mind az eredeti, mind a transzformált koordináták három 2D-s pontból álljanak.');
end

% Az eredeti háromszög mátrixának létrehozása ún. homogén koordinátákkal
X = [haromszog'; ones(1, 3)];

% A transzformált háromszög mátrixának létrehozása
Y = [kepek'; ones(1, 3)];

% Az affin transzformáció elvégzése
transzformacioMatrix = Y / X;

disp('Az affin transzformáció mátrixa:');
disp(transzformacioMatrix);
end


% Teszteléshez:
% affin2_function([0, 0; 1, 0; 0, 1], [2, 1; 3, 1; 2, 3]);
