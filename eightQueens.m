%%%%%%%%%%%%%%%%%      Under DEVELOPING      %%%%%%%%%%%%%%%%%%

% MATLAB code to solve the 8-Queens problem

function eightQueens()

    % Solve the 8-Queens problem
    board = zeros(8, 8);  % Create an 8x8 chessboard
    solutions = solveQueens(8);  % Get one solution

    % Display the solution on the chessboard
    disp('Solution for 8-Queens problem:');
    disp(solutions);  % Show the position of queens on the board

    % Visualize the solution using a chessboard display
    displayBoard(solutions);
end

% Function to solve the N-Queens problem using backtracking
function solutions = solveQueens(N)
    solutions = zeros(1, N);  % This will store queen positions
    placeQueens(solutions, 1, N);  % Start placing queens row by row
end

% Recursive function to place queens on the board
function success = placeQueens(solutions, row, N)
    if row > N
        success = true;  % If all queens are placed, solution is found
        return;
    end
    success = false;
    for col = 1:N
        if isSafe(solutions, row, col)
            solutions(row) = col;  % Place queen in the current row and column
            if placeQueens(solutions, row + 1, N)
                success = true;
                return;
            end
        end
    end
end

% Function to check if placing a queen is safe
function safe = isSafe(solutions, row, col)
    for i = 1:(row - 1)
        if solutions(i) == col || abs(solutions(i) - col) == abs(i - row)
            safe = false;  % Check for attacks in the same column or diagonal
            return;
        end
    end
    safe = true;
end

% Function to display the chessboard with queens
function displayBoard(solutions)
    N = length(solutions);
    chessboard = zeros(N, N);

    % Place queens on the chessboard
    for i = 1:N
        chessboard(i, solutions(i)) = 1;
    end

    % Display the chessboard
    figure;
    imagesc(chessboard);
    colormap(gray);
    axis equal;
    title('8-Queens Solution');
    set(gca, 'XTick', 1:N, 'YTick', 1:N, 'XTickLabel', 1:N, 'YTickLabel', 1:N);
    xlabel('Columns');
    ylabel('Rows');

    % Mark the queen positions with 'Q'
    for i = 1:N
        text(solutions(i), i, 'Q', 'FontSize', 18, 'HorizontalAlignment', 'center', 'Color', 'r');
    end
end
