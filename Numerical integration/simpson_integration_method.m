f = input('Enter the function: ');
a = input('Enter the lower limit of integral: ');
b = input('Enter the upper limit of integral: ');
n = input('Enter the total number of subintervals: ');
h = (b - a) / n;
sum = (f(a) + f(b) * (1/3));

for i = (1:(n / 2 - 1))
    sum = sum + (1 / 3) * (4 * f(a + (2 * i - 1) * h) + 2 * f(a + (2 * i) * h));
end

I = h * sum