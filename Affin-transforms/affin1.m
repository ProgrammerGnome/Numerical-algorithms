function T = affin1_function(p1, p2)
    % Origót fixen hagyó affin transzformáció mátrixának meghatározása
    % Bemenet:
    % - p1: az (0,1) pont képe a transzformációban
    % - p2: az (1,0) pont képe a transzformációban
    % Kimenet:
    % - T: az affin transzformáció mátrixa
    
    if nargin < 2
        % Grafikus bemenet, ha nincs paraméter megadva
        disp('Kérlek, kattints a képekre a grafikus ablakban:');
        figure;
        hold on;
        axis equal;
        grid on;
        xlabel('x');
        ylabel('y');
        title('Válaszd ki a transzformáció képeit!');
        
        % Rajzoljuk ki az alapvektorokat
        quiver(0, 0, 0, 1, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5); % (0,1)
        text(0, 1, '(0,1)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
        quiver(0, 0, 1, 0, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5); % (1,0)
        text(1, 0, '(1,0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
        
        % Felhasználói pontkiválasztás
        [x1, y1] = ginput(1); % (0,1) képe
        plot(x1, y1, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
        text(x1, y1, sprintf('(%0.2f, %0.2f)', x1, y1), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
        
        [x2, y2] = ginput(1); % (1,0) képe
        plot(x2, y2, 'bo', 'MarkerSize', 8, 'LineWidth', 2);
        text(x2, y2, sprintf('(%0.2f, %0.2f)', x2, y2), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
        
        p1 = [x1; y1];
        p2 = [x2; y2];
        
        close;
    end
    
    % Az origó fix, ezért az affin transzformáció mátrixa az alábbi formában van:
    T = [p2, p1]; % Ez speciális eset!
end
