% Loads an image.
% Extracts features (for classification).
% Uses K-Nearest Neighbors (KNN) and Convolutional Neural Networks (CNN) to classify the image content.
% Reports image details such as size, color channels, and predicted class.
% Replace images/sample.jpg with your own image.
% KNN uses the handwritten digit dataset as an example. For your own images, you'd need a labeled dataset and feature extraction strategy (e.g., HOG, SIFT).
% CNN uses the AlexNet pretrained model, suitable for general object classification.





% main.m - Image Analysis with KNN and CNN

% Clear environment
clc; clear;

% Load image
imgPath = 'images/sample.jpg'; % change this path
img = imread(imgPath);
fprintf('Loaded image: %s\n', imgPath);

% Display image info
info = imfinfo(imgPath);
fprintf('Image size: %dx%d\n', size(img,1), size(img,2));
fprintf('Color type: %s\n', info.ColorType);
fprintf('Bit depth: %d\n\n', info.BitDepth);

% Resize for CNN
imgResized = imresize(img, [227 227]);  % For AlexNet input size

%% ================== CNN Classification ==================
fprintf('--- CNN Classification ---\n');
net = alexnet;
label_cnn = classify(net, imgResized);
fprintf('CNN Prediction: %s\n\n', string(label_cnn));

%% ================== KNN Classification ==================

% Load dataset (example: digit dataset)
fprintf('--- KNN Classification ---\n');
digitDatasetPath = fullfile(matlabroot, 'toolbox', 'nnet', 'nndemos', ...
    'nndatasets', 'DigitDataset');

imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

% Preprocess
imds.ReadFcn = @(x) imresize(rgb2gray(imread(x)), [28 28]);

% Extract features for training set
numTrain = 1000;
trainImgs = readall(imds);
trainImgs = trainImgs(1:numTrain);
features = zeros(numTrain, 784);
labels = imds.Labels(1:numTrain);

for i = 1:numTrain
    features(i,:) = double(reshape(trainImgs{i}, 1, [])) / 255;
end

% Train KNN
mdlKNN = fitcknn(features, labels, 'NumNeighbors', 3);

% Prepare test image
testImg = rgb2gray(imresize(img, [28 28]));
testFeature = double(reshape(testImg, 1, [])) / 255;

% Predict
label_knn = predict(mdlKNN, testFeature);
fprintf('KNN Prediction: %s\n', string(label_knn));
