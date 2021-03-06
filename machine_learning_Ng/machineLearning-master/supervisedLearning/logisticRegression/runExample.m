%% Logistic Regression

%% Initialization
clear ; close all; clc

%% Load Data
%  The first two columns contains the exam scores and the third column
%  contains the label

data = load('inputTrainingSet1.txt');
X = data(:, [1, 2]); % X is a #OfExamScores x 2 matrix
y = data(:, 3);      % y is a #OfExamScores x 1 matrix

%  It's always a good idea to first plot the problem to solve
fprintf(['Plotting data with + indicating (y = 1) examples and o ' ...
         'indicating (y = 0) examples.\n']);
plotData(X, y);

% Put some labels 
hold on;
% Labels and Legend
title('Acceptance of Previous Students Based on Scores on 2 Exams')
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
legend('Admitted Students', 'Not admitted Students')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============ Compute Cost and Gradient ============
%  implement the cost and gradient for logistic regression

%  Setup the data matrix appropriately, and add ones for the intercept term
%  展示计算第一次得到的costj，theta
[m, n] = size(X);

% Add intercept term to x and X_test
X = [ones(m, 1) X];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

% Compute and display initial cost and gradient
[cost, gradient] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', gradient);
 
fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============= Optimizing using fminunc  =============
%  use a built-in function (fminunc) to find the
%  optimal parameters theta. Octave's fminunc is an optimization
%  solver that finds the minimum of an unconstrained function. 
%  For logistic regression, you want to optimize the cost
%  function J(theta) with parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
% NOTE: that by using fminunc, you do not have to write any loops yourself,
% or set a learning rate like you did for gradient descent. You ONLY need
% to provide a function calculating the cost and the gradient.

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);

% Plot Boundary
plotDecisionBoundary(theta, X, y);

% Put some labels 
hold on;
% Labels and Legend
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============== Part 4: Predict and Accuracies ==============
%  After learning the parameters, you'll like to use it to predict the outcomes
%  on unseen data. In this part, you will use the logistic regression model
%  to predict the probability that a student with score 45 on exam 1 and 
%  score 85 on exam 2 will be admitted.
%
%  Furthermore, you will compute the training and test set accuracies of 
%  our model.
%
%  Your task is to complete the code in predict.m

%  Predict probability for a student with score 45 on exam 1 
%  and score 85 on exam 2 

prob = sigmoid([1 45 85] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n\n'], prob);

% Compute accuracy on our training set
p = predict(theta, X);
% 取数组的平均值
fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

