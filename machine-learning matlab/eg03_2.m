function eg03_2(n, N)
%随机梯度算法对高斯核模型进行最小二乘学习法的实例
    % init
    rng(0, 'v5uniform'); rng(0, 'v5normal');
    %（rng(种子)种子使用非负整数种子种子，使rand、randi和randn产生一个可预测的数字序列。）
    % recommended, use it in future instead of
    % rand('state', 0); randn('state', 0);
%     rng(seed, generator) 和 rng(‘shuffle’, generator) 另外指定 rand、randi 和 randn 使用的随机数生成函数的类型。generator 输入为以下项之一：
% ‘twister’：Mersenne Twister
% ‘simdTwister’：面向 SIMD 的快速 Mersenne Twister 算法
% ‘combRecursive’：合并的多个递归
% ‘multFibonacci’：乘法滞后 Fibonacci
% ‘v5uniform’：传统 MATLAB? 5.0 均匀生成函数
% ‘v5normal’：传统 MATLAB 5.0 正常生成函数
% ‘v4’：传统 MATLAB 4.0 生成函数

    if nargin < 2
        n = 50; N = 1000;
    end

    % constant
    x = linspace(-3, 3, n)';
    X = linspace(-3, 3, N)';
    pix = pi * x;
    y = sin(pix) ./ pix + 0.1 * x + 0.05 * randn(n, 1);

    % plot preparation
    figure('Name', 'example 3-2 A'); clf; hold on;

    % iteration parameter
    hh = 2 * 0.3 * 0.3;
    K = exp(-(repmat(X .^ 2, 1, n) + repmat((x .^ 2)', N, 1) - 2 * X * x') / hh);
%     repmat全称是Replicate Matrix ，
%     意思是复制和平铺矩阵，是MATLAB里面的一个函数。
%     语法有B = repmat(A,m,n)，
%     将矩阵 A 复制 m×n 块，即把 A 作为 B 的元素，B 由 m×n 个 A 平铺而成。
%     B 的维数是 [size(A,1)*m, size(A,2)*n] 。
    t0 = randn(n, 1);
    e = 0.1;
    eps = 1e-6;
    id = 1;

    % iteration, plot some data within iteration
    for o = 1 : n * 1000
        index = ceil(rand * n);
        ki = exp(-(x - x(index)) .^ 2 / hh);
        t = t0 - e * ki * (ki' * t0 - y(index));
        if norm(t - t0) < eps, break, end
        if (o == 1) || (rem(o, 100) == 0 && o / 100 < 5)
            plotFigure(3, 2, id, num2str(o), X, K *  t, x, y);
            id = id + 1;
        end
        t0 = t;
    end

    % plot final iteration result
    plotFigure(3, 2, id, num2str(o), X, K * t, x, y);
    saveas(gcf, 'eg03_2_A', 'png');
    figure('Name', 'example 3-2 B'); clf; hold on;
    plot(X, K * t, 'g-'); plot(x, y, 'bo');
    setFigure('example 3-2 final result');

    % save figure
    saveas(gcf, 'eg03_2_B', 'png');

    % sub-function, plot sub-figure
    function [] = plotFigure( M, N, id, titlesuffix, x1, y1, x2, y2 )
        subplot(M, N, id);
        plot(x1, y1, 'g-', x2, y2, 'b.');
        setFigure(strcat('Iteration: ', titlesuffix));
    end

    % sub-function, figure setting
    function [] = setFigure( tag )
        title(tag); xlabel('\itx');
        xlim([-2.8, 2.8]); ylim([-0.5, 1.2]);
    end
end