f = input('Enter the function: ');
a = input('Enter the lower limit of integral: ');
b = input('Enter the upper limit of integral: ');
n = input('Enter the total number of subintervals: ');
h = (b - a) / n;
sum = (f(a) + f(b) * (1/2));

for i = (1:(n - 1))
    sum = sum + f(a + i * h);
end

I = h * sum