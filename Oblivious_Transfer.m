% Oblivious Transfer Simulation in MATLAB
clc;
clear;

% Sender's messages
M0 = 'Secret Message 0';
M1 = 'Secret Message 1';

% Generate a random key for encryption
rng('shuffle'); % Seed the random number generator
K = randi([1, 255]); % Generate a random key between 1 and 255

% Encrypt messages using XOR
Enc_M0 = xor_encrypt(M0, K);
Enc_M1 = xor_encrypt(M1, K);

% Receiver chooses which message to retrieve (0 for M0 or 1 for M1)
choice = input('Enter your choice (0 or 1): ');

% Determine receiver's key based on choice
if choice == 0
    K_receiver = K; % Receiver uses the correct key if they choose M0
else
    K_receiver = K + 1; % Receiver uses an incorrect key for M1 (simulation)
end

% Decrypt the chosen message
if choice == 0
    Received_Message = xor_encrypt(Enc_M0, K_receiver);
else
    Received_Message = xor_encrypt(Enc_M1, K_receiver);
end

% Display results
disp('--- Oblivious Transfer Results ---');
disp(['Sender''s Messages: M0 = ', M0, ', M1 = ', M1]);
disp(['Encrypted Messages: Enc_M0 = ', char(Enc_M0), ', Enc_M1 = ', char(Enc_M1)]);
disp(['Receiver''s Choice: ', num2str(choice)]);
disp(['Receiver''s Retrieved Message: ', Received_Message]);

% Function to XOR encrypt/decrypt a string
function encrypted = xor_encrypt(msg, key)
    % Convert the string to ASCII values
    ascii_vals = double(msg);
    % XOR each character with the key
    encrypted_ascii = bitxor(ascii_vals, key);
    % Convert back to characters
    encrypted = char(encrypted_ascii);
end
