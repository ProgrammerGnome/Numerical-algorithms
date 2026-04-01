x = input('Enter values for x: ');
y = input('Enter values for y: ');
x0 = input('data needed for which?: ');
n = length(x)-1;
sum = 0;

for i = 1:(n + 1)
    pr = 1;
    
    for j = 1:(n + 1)
        if j ~= i
            pr = pr * (x0 - x(j)) / (x(i) - x(j));
        end
    end
    sum = sum + pr * y(i);
end

y0=sum