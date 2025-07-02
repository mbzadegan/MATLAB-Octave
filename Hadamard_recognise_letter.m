% MATLAB example that uses the Hadamard transform to extract features from letter images and perform simple template matching to recognize letters (A–Z).
% Requirements:
% A folder letters/ containing binary or grayscale letter images: A.png, B.png, ..., Z.png.
% Each image should be 32×32 pixels, or the script will resize it.
% A test image, e.g., test_letter.png.


function recognize_letter_hadamard()
    % Settings
    letter_dir = 'letters/';
    image_size = 32;
    letters = 'A':'Z';

    % Generate Hadamard matrix
    H = hadamard(image_size);

    % Load reference templates and compute Hadamard features
    fprintf('[INFO] Loading templates...\n');
    templates = zeros(length(letters), image_size * image_size);
    for i = 1:length(letters)
        filename = fullfile(letter_dir, [letters(i), '.png']);
        img = preprocess_image(filename, image_size);
        HT = H * img * H';  % 2D Hadamard Transform
        templates(i, :) = HT(:)';  % Flatten
    end

    % Load test image
    test_img = preprocess_image('test_letter.png', image_size);
    HT_test = H * test_img * H';
    test_vector = HT_test(:)';

    % Match test vector to templates
    distances = vecnorm(templates - test_vector, 2, 2);  % Euclidean distance
    [~, idx] = min(distances);
    matched_letter = letters(idx);

    % Output result
    fprintf('[RESULT] Detected letter: %s\n', matched_letter);
end

function img = preprocess_image(filename, size_target)
    img = imread(filename);
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = imresize(img, [size_target, size_target]);
    img = im2double(img);
end
