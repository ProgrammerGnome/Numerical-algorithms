function egyutthatok = lnmaprox_function(polinomFokszam, csomopontokX, csomopontokY, grafikon)
    % Legkisebb négyzetek módszerével approximál
    % Bemenet:
    % - polinomFokszam: approximációs polinom foka
    % - csomopontokX: csomópontok x koordinátái
    % - csomopontokY: csomópontok y koordinátái
    % - grafikon: 1, ha grafikont szeretnénk megjeleníteni; 0, ha nem
    % Visszatér:
    % - egyutthatok: az approximációs polinom együtthatói

    % Ellenőrzés: azonos méretű csomópontok
    if numel(csomopontokX) ~= numel(csomopontokY)
        error("A csomópontok X és Y vektorok elemeinek azonos méretűnek kell lenniük.");
    end

    % Polinom együtthatók számítása
    egyutthatok = polyfit(csomopontokX, csomopontokY, polinomFokszam);

    % Közelítő polinom kiszámítása sűrűbb intervallumban a grafikus megjelenítéshez
    finomX = linspace(min(csomopontokX), max(csomopontokX), 1000);
    finomY = polyval(egyutthatok, finomX);

    % Közelítő polinom értékei az eredeti csomópontokban
    approxPolinomY = polyval(egyutthatok, csomopontokX);

    % Grafikus ábra megjelenítése
    if grafikon == 1
        figure;
        hold on;

        % Eredeti csomópontok
        plot(csomopontokX, csomopontokY, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5, 'DisplayName', 'Csomópontok');

        % Közelítő polinom
        plot(finomX, finomY, 'r-', 'LineWidth', 2, 'DisplayName', 'Közelítő polinom');

        % Tengelyek, cím, jelmagyarázat
        xlabel('X tengely');
        ylabel('Y tengely');
        title(sprintf('Legkisebb négyzetek módszerével közelített polinom (fok: %d)', polinomFokszam));
        legend('Location', 'best');
        grid on;

        hold off;
    end
end



% PÉLDA FÜGGVÉNYHÍVÁS!!!

% Példa bemenetek
csomopontokX = [-2, -1, 0, 1, 2];
csomopontokY = [-4, -2, 1, 2, 4];

% Polinom foka
polinomFokszam = 2;

% Grafikus ábra megjelenítése (1: igen, 0: nem)
grafikon = 0;

% Függvényhívás
egyutthatok = lnmaprox_function(polinomFokszam, csomopontokX, csomopontokY, grafikon);

% Eredmény kiíratása
disp('Közelítő polinom együtthatói:');
disp(egyutthatok);
