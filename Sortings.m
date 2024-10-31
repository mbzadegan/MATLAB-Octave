% Function to generate N random numbers
function randomNumbers = generateRandomNumbers(N)
    randomNumbers = rand(1, N) * 100;  % Generates random numbers between 0 and 100
end

% Bubble Sort implementation
function sortedArray = bubbleSort(A)
    n = length(A);
    sortedArray = A;
    for i = 1:n-1
        for j = 1:n-i
            if sortedArray(j) > sortedArray(j+1)
                % Swap elements
                temp = sortedArray(j);
                sortedArray(j) = sortedArray(j+1);
                sortedArray(j+1) = temp;
            end
        end
    end
end

% Quick Sort implementation
function sortedArray = quickSort(A)
    if numel(A) <= 1
        sortedArray = A;
    else
        pivot = A(1);
        left = A(A < pivot);
        right = A(A > pivot);
        sortedArray = [quickSort(left), pivot, quickSort(right)];
    end
end

% Main function to sort using different methods and output processing times
function measureSortingTimes(N)
    % Generate random numbers
    numbers = generateRandomNumbers(N);

    % Measure processing time for Bubble Sort
    bubbleNumbers = numbers; % Copy array for Bubble Sort
    tic;
    bubbleSort(bubbleNumbers);
    time_bubble = toc;
    
    % Measure processing time for Quick Sort
    quickNumbers = numbers; % Copy array for Quick Sort
    tic;
    quickSort(quickNumbers);
    time_quick = toc;
    
    % Measure processing time for MATLAB's built-in sort
    builtinNumbers = numbers; % Copy array for MATLAB's sort
    tic;
    sort(builtinNumbers);
    time_builtin = toc;
    
    % Display processing times
    fprintf('Processing time for Bubble Sort: %.6f seconds\n', time_bubble);
    fprintf('Processing time for Quick Sort: %.6f seconds\n', time_quick);
    fprintf('Processing time for MATLAB''s built-in sort: %.6f seconds\n', time_builtin);
end

% Example usage: Sort and measure processing time for 1000 random numbers
measureSortingTimes(1000);
