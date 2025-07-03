% Convolutional Neural Network (Deep Learning Toolbox)
% for image classification using the built-in MNIST-like dataset (digitDatasetPath).

% Load digit dataset (built-in)
digitDatasetPath = fullfile(matlabroot, 'toolbox', 'nnet', 'nndemos', ...
    'nndatasets', 'DigitDataset');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% Split into training and test
[imdsTrain, imdsTest] = splitEachLabel(imds, 0.8, 'randomized');

% Define CNN architecture
layers = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3, 8, 'Padding','same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    convolution2dLayer(3, 16, 'Padding','same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% Set training options
options = trainingOptions('adam', ...
    'MaxEpochs', 5, ...
    'ValidationData', imdsTest, ...
    'ValidationFrequency', 30, ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% Train CNN
net = trainNetwork(imdsTrain, layers, options);

% Test accuracy
YPred = classify(net, imdsTest);
YTest = imdsTest.Labels;
accuracy = sum(YPred == YTest)/numel(YTest);
fprintf('[CNN] Test Accuracy: %.2f%%\n', accuracy*100);
