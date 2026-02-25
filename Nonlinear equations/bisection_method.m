f = input('Enter a function = ');
a = input('Enter lower bound of assumed interval = ');
b = input('Enter upper bound of assumed interval = ');
n = input('Enter the number of loops = ');
e = input('Enter the tolerance = ');

if f(a) * f(b) <= 0
    for i = 1:n
        c = (a + b) / 2;

        fprintf('P%d=%.4f\n', i, c);

        if abs(c - a) <= e || abs(b - c) <= e
            break;
        end
            if f(a) * f(c) <= 0
                b = c;
            elseif f(b) * f(c) <= 0
                a = c;
            end
    end
else
    disp('try another interval');
end

%@(x)x^5-sin(3*x)-exp(2*x)
%@(x)x^2-5*x+6
%@(x)sin(x) - cos(x)