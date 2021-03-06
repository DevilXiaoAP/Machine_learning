function J = computeCostMulti(X, y, theta)
%COMPUTECOSTMULTI Compute cost for linear regression with multiple variables
%   J = COMPUTECOSTMULTI(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% Compute the cost(J) of a particular choice of theta

% hypothesis = mx1 column vector
% X = mxn matrix
% theta = nx1 column vector
hypothesis = X * theta;

% errors = mx1 column vector
% y = mx1 column vector
errors = hypothesis - y;

% square all elements individually within 
% column vector errors

% squareOfErrors = mx1 column vector
squareOfErrors = (errors).^2;

% sumOfSquareErrors = single number
sumOfSquareErrors = sum(squareOfErrors);

% J = single number
J = 1/(2 * m) * sumOfSquareErrors;

end
