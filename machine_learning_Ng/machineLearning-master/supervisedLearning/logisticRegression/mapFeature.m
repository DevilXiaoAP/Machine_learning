function out = mapFeature(X1, X2)
% MAPFEATURE Feature mapping function to polynomial features
%   映射特征映射函数到多项式特征
%   MAPFEATURE(X1, X2) maps the two input features     mapfeature（x1，x2）映射两个输入特征
%   to quadratic features used in the regularization exercise.   到正则化练习中使用的二次特征。
%   返回具有更多功能的新功能数组，其中包括x1，x2，x1.^2，x2.^2，x1*x2，x1*x2.^2等。
%   Returns a new feature array with more features, comprising of 
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%   输入x1、x2的大小必须相同
%   Inputs X1, X2 must be the same size
%   mapfuture利用已有的特征来创造出更多的特征，第一个循环输出X1，X2，第二个循环输出X1^2,X1+X2,X2^2,第三个循环输出X1^3等

degree = 6;
out = ones(size(X1(:,1)));
for i = 1:degree
    for j = 0:i
        out(:, end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end