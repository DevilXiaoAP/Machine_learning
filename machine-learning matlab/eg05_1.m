function eg05_1(n, N)
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
    pix = pi * x;
    y = sin(pix) ./ (pix) + 0.1 * x + 0.2 * randn(n, 1);

    % kernel function
    x2 = x .^ 2;
    X2 = X .^ 2;
    hh = 2 * 0.3 ^ 2;
    l = 0.1;
    k = exp(-(repmat(x2, 1, n) + repmat(x2', n, 1) - 2 * x * x') / hh);
    K = exp(-(repmat(X2, 1, n) + repmat(x2', N, 1) - 2 * X * x') / hh);
    t0 = randn(n, 1);

    k2 = k ^ 2;
    ky = k * y;

    for o = 1 : 1000
        t1 = (k2 + l * pinv(diag(abs(t0)))) \ ky;
       %1．B=pinv(A)函数返回矩阵A的伪逆矩阵。如果矩阵A是可逆（非奇异）的，那么pinv(A)与inv(A)的结果是一样的，而且pinv比inv效率低。但如果矩阵A是奇异矩阵，则inv(A)不存在，但pinv(A)仍然存在，并表现出一些与逆矩阵类似的性质。在pinv函数中，A不一定是方阵。

        if norm(t1 - t0) < 0.001, break, end
        t0 = t1;
    end

    F1 = K * t1;
    t2 = (k ^ 2 + l * eye(n)) \ (k * y);
    F2 = K * t2;

    figure('Name', 'example 5-1'); clf; hold on;
    plot(X, F1, 'g-', X, F2, 'r-', x, y, 'bo');
    legend('L1-Constrained LS', 'L2-Constrained LS', 'Input Data');
    axis([-2.8 2.8 -1 1.5]);
    title('L1-Constrained LS & L2-Constrained LS');
    xlabel('\itx'); ylabel('\itx');

    % save figure
    saveas(gcf, 'eg05_1', 'png');
end