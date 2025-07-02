% Load grayscale image
img = imread('your_image.png');
if size(img, 3) == 3
    img = rgb2gray(img);  % Convert to grayscale if RGB
end

% Resize image to 128x128 (must be power of 2)
img = imresize(img, [128 128]);

% Normalize image to range [0, 1]
img_norm = double(img) / 255;

% Generate Hadamard matrix
N = size(img_norm, 1);
H = hadamard(N);

% Apply Hadamard Transform
HT = H * img_norm * H';

% Inverse Hadamard Transform
reconstructed = H' * HT * H / (N^2);  % Normalize by N^2

% Display original and reconstructed images
figure;
subplot(1,2,1);
imshow(img_norm, []);
title('Original Image');

subplot(1,2,2);
imshow(reconstructed, []);
title('Reconstructed Image (Hadamard)');
