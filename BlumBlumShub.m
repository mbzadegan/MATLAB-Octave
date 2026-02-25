% Blum Blum Shub (BBS) Random Number Generator.
clc;
clear;

% Parameters for the BBS algorithm
p = 11; % Prime number p (must be congruent to 3 mod 4)
q = 19; % Prime number q (must be congruent to 3 mod 4)
n = p * q; % Modulus (product of two primes)

% Initial seed (must be coprime with n and non-zero)
seed = 3;
if gcd(seed, n) ~= 1
    error('Seed must be coprime with n.');
end

% Number of random bits to generate
num_bits = 16;

% Generate random bits using the BBS algorithm.
x = mod(seed^2, n); % Initialize x
random_bits = zeros(1, num_bits); % Array to store random bits

for i = 1:num_bits
    x = mod(x^2, n);       % Next state
    random_bits(i) = mod(x, 2); % Extract least significant bit (LSB)
end

% Display the results
disp('Blum Blum Shub Random Bits:');
disp(random_bits);

% Convert the binary sequence to a random decimal number
random_number = 0;
for i = 1:num_bits
    random_number = random_number + random_bits(i) * 2^(num_bits - i);
end
disp('Random Number:');
disp(random_number);
