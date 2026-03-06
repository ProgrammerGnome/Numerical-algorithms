g = input('write down the funnction = ');
h = input('write down the derivative =');
x0 = input('initial_guess = ');
n = input('enter the required number of loop = ');
e = input('enter the tolerance = ');

for i = 1:n
    x1 = x0 - g(x0) / h(x0);
    
    fprintf('x%d = %.4f\n', i, x1)
    
    if abs(x1 - x0)<e
        break
    end
 x0 = x1;
end