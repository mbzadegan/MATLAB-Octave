% k-Nearest Neighbors (Statistics and Machine Learning Toolbox).


% Resize and extract features (flatten 28x28 into 1x784 vectors)
inputSize = [28 28];
numTrain = 1000; % to speed up training
numTest = 500;

% Read images and labels for training
[trainImgs, trainLabels] = readall(imdsTrain);
trainImgs = imresize(cell2mat(trainImgs), [28 28]);
trainImgs = reshape(trainImgs, 28, 28, 1, []);
trainImgs = reshape(trainImgs, [], size(trainImgs,4))';  % N x 784

% Read images and labels for testing
[testImgs, testLabels] = readall(imdsTest);
testImgs = imresize(cell2mat(testImgs), [28 28]);
testImgs = reshape(testImgs, 28, 28, 1, []);
testImgs = reshape(testImgs, [], size(testImgs,4))';  % N x 784

% Limit to a smaller subset for demo
trainImgs = double(trainImgs(1:numTrain,:)) / 255;
trainLabels = trainLabels(1:numTrain);
testImgs = double(testImgs(1:numTest,:)) / 255;
testLabels = testLabels(1:numTest);

% Train kNN classifier
Mdl = fitcknn(trainImgs, trainLabels, 'NumNeighbors', 3);

% Predict and evaluate
predictedLabels = predict(Mdl, testImgs);
acc_knn = sum(predictedLabels == testLabels) / numel(testLabels);
fprintf('[kNN] Test Accuracy: %.2f%%\n', acc_knn*100);
