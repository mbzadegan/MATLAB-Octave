% MATLAB code to find and display prime Fibonacci numbers

% Initialize the first two Fibonacci numbers
fib(1) = 0;
fib(2) = 1;

% Number of Fibonacci numbers to generate (you can increase the number)
numFib = 50;  % Adjust it to get more Fibonacci numbers

% Generate Fibonacci numbers

for i = 3:numFib
    fib(i) = fib(i-1) + fib(i-2);
end

% Display prime Fibonacci numbers
fprintf('Prime Fibonacci Numbers:\n');
for i = 1:numFib
    if isprime(fib(i)) && fib(i) > 1
        fprintf('%d\n', fib(i));
    end
end
