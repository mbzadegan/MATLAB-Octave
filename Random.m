% MATLAB code to assess random numbers quality.

% Number of random numbers to generate.
numValues = 1000;  % Adjust this for a larger sample

% Generate random numbers between 0 and 1
randomNumbers = rand(1, numValues);

% 1. Uniformity check: Histogram plot
figure;
histogram(randomNumbers, 20);  % Histogram with 20 bins
title('Histogram of Random Numbers');
xlabel('Random Number Value');
ylabel('Frequency');
grid on;

% 2. Statistical properties
meanValue = mean(randomNumbers);
varianceValue = var(randomNumbers);

% Display the mean and variance
fprintf('Mean of Random Numbers: %.4f\n', meanValue);
fprintf('Variance of Random Numbers: %.4f\n', varianceValue);

% 3. Autocorrelation test
figure;
autocorr(randomNumbers, 50);  % Autocorrelation up to lag 50
title('Autocorrelation of Random Numbers');
grid on;

% 4. Chi-Square test for uniformity
% Divide into bins and calculate expected frequency
numBins = 10;
observedFrequencies = histcounts(randomNumbers, numBins);
expectedFrequencies = numValues / numBins * ones(1, numBins);

% Perform the Chi-Square test
[chi2stat, pValue] = chi2gof(randomNumbers, 'NBins', numBins);

% Display the Chi-Square test result
fprintf('Chi-Square Test Statistic: %.4f\n', chi2stat);
fprintf('P-value of Chi-Square Test: %.4f\n', pValue);

% Interpretation of Chi-Square test result
if pValue > 0.05
    disp('The random numbers pass the Chi-Square uniformity test (p > 0.05).');
else
    disp('The random numbers fail the Chi-Square uniformity test (p <= 0.05).');
end
