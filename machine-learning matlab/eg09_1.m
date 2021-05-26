function eg09_1(n)
    % init
    rng(0, 'v5uniform'); rng(0, 'v5normal');
    % recommended, use it in future instead of
    % rand('state', 0); randn('state', 0);
    if nargin < 1
        n = 50;
    end
    x = randn(n, 2);
    y = 2 *(x(:, 1) > x(:, 2)) - 1;
    X0 = linspace(-3, 3, n);
    [X(:, :, 1), X(:, :, 2)] = meshgrid(X0);

    d = ceil(2 * rand);
    [xs, xi] = sort(x(:, d));
    el = cumsum(y(xi));
    eu = cumsum(y(xi(end : -1 : 1)));
    e = eu(end - 1 : -1 : 1) - el(1 : end - 1);
    [~, ei] = max(abs(e));
    c = mean(xs(ei : ei + 1));
    s = sign(e(ei));
    Y = sign(s*(X(:, :, d) - c));

    figure('Name', 'Ensemble Pruning Example'); clf; hold on;
    title('Ensemble Pruning Example')
    axis([-3 3 -3 3]); axis square;
    colormap([1 0.7 1; 0.7 1 1]);
    contourf(X0, X0, Y);
    plot(x(y == 1, 1), x(y == 1, 2), 'bo');
    plot(x(y == -1, 1), x(y == -1, 2), 'rx');
    saveas(gcf, 'eg09_1', 'png');
end
% cumsum是matlab中一个函数，通常用于计算一个数组各行的累加值，函数用法是B = cumsum(A,dim)，或B = cumsum(A)。
% 格式一：B = cumsum(A)
% 这种用法返回数组不同维数的累加和。
% 格式二：B = cumsum(A,dim)
% 这种调用格式返回A中由标量dim所指定的维数的累加和。例如：cumsum(A,1)返回的是沿着第一维（各列）的累加和，cumsum(A,2)返回的是沿着第二维（各行）的累加和。