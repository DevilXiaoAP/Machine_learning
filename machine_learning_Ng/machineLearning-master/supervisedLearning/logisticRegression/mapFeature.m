function out = mapFeature(X1, X2)
% MAPFEATURE Feature mapping function to polynomial features
%   ӳ������ӳ�亯��������ʽ����
%   MAPFEATURE(X1, X2) maps the two input features     mapfeature��x1��x2��ӳ��������������
%   to quadratic features used in the regularization exercise.   ��������ϰ��ʹ�õĶ���������
%   ���ؾ��и��๦�ܵ��¹������飬���а���x1��x2��x1.^2��x2.^2��x1*x2��x1*x2.^2�ȡ�
%   Returns a new feature array with more features, comprising of 
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%   ����x1��x2�Ĵ�С������ͬ
%   Inputs X1, X2 must be the same size
%   mapfuture�������е�������������������������һ��ѭ�����X1��X2���ڶ���ѭ�����X1^2,X1+X2,X2^2,������ѭ�����X1^3��

degree = 6;
out = ones(size(X1(:,1)));
for i = 1:degree
    for j = 0:i
        out(:, end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end