f = input('enter any function = ');
a = input('enter lower bound of the assumed interval = ');
b = input('enter upper bound of the assumed interval = ');
n = input('enter the number of loops = ');
e = input('enter the tolerance = ');

if f(a) * f(b) <= 0
    for i = 1:n
        c = (f(b) * a - f(a) * b) / (f(b) - f(a));

        fprintf('P%d = %.6f\n', i, c)
        
        if abs(c - a) <= e || abs(b - c) <= e
            break
        end

        if f(a) * f(c) <= 0
            b = c;
        elseif f(b) * f(c) <= 0
            a = c;
        end
    end

else
    disp('try another interval')
end