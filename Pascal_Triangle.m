function pascalTriangle = generatePascalTriangle(n)
    % Initialize an empty cell array to store each row.
    pascalTriangle = cell(n, 1);

    % Loop through each row
    for i = 0:n-1
        % Generate each element in the row using the binomial coefficient
        pascalTriangle{i+1} = arrayfun(@(k) nchoosek(i, k), 0:i);
    end

    % Display Pascal's Triangle
    for i = 1:n
        % Center align the rows for visual effect
        fprintf('%s\n', sprintf('%*d', 3, pascalTriangle{i}));
    end
end

% Example usage: Define the number of rows
n = 5;  % Change n to any positive integer
generatePascalTriangle(n);
