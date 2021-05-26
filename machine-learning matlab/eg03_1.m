function eg03_1(n, N)
%线性最小二乘法
    % init
    rng(0, 'v5uniform'); rng(0, 'v5normal');
    % recommended, use it in future instead of
    % rand('state', 0); randn('state', 0);
    if nargin < 2
        n = 50; N = 1000;
    end

    % constant
    x = linspace(-3, 3, n)';
    X = linspace(-3, 3, N)';
    %linspace是Matlab中的均分计算指令，用于产生x1,x2之间的N点行线性的矢量。
    pix = pi * x;
    y = sin(pix) ./ pix + 0.1 * x + 0.05 * randn(n, 1);

    % base function
    p(:, 1) = ones(n, 1);
    P(:, 1) = ones(N, 1);
    for jj = 1 : 15
        p(:, 2 * jj) = sin(jj / 2 * x); p(:, 2 * jj + 1) = cos(jj / 2 * x);
        P(:, 2 * jj) = sin(jj / 2 * X); P(:, 2 * jj + 1) = cos(jj / 2 * X);
    end

    % solve
    t = p \ y;
    F = P * t;

    % plot
    figure('Name', 'design function'); clf; hold on;
    plot(X, F, 'g-'); plot(x, y, 'bo');
    setFigure('design function');

    % save figure
    saveas(gcf, 'eg03_1', 'png');

    % sub-function, figure setting
    function [] = setFigure( tag )
        title(tag); xlabel('\itx');
        xlim([-2.8, 2.8]); ylim([-0.5, 1.2]);
    end
end