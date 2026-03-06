g = input('write down the funnction = ');
x0 = input('initial_guess = ');
n = input('enter the required number of loop = ');
e = input('enter the tolerance = ');

for i = 1:n
    x1 = g(x0);
    
    fprintf('x%d = %.4f\n', i, x1)
    
    if abs(x1 - x0) < e
        break
    end

 x0 = x1
end