function eg03_2(n, N)
%����ݶ��㷨�Ը�˹��ģ�ͽ�����С����ѧϰ����ʵ��
    % init
    rng(0, 'v5uniform'); rng(0, 'v5normal');
    %��rng(����)����ʹ�÷Ǹ������������ӣ�ʹrand��randi��randn����һ����Ԥ����������С���
    % recommended, use it in future instead of
    % rand('state', 0); randn('state', 0);
%     rng(seed, generator) �� rng(��shuffle��, generator) ����ָ�� rand��randi �� randn ʹ�õ���������ɺ��������͡�generator ����Ϊ������֮һ��
% ��twister����Mersenne Twister
% ��simdTwister�������� SIMD �Ŀ��� Mersenne Twister �㷨
% ��combRecursive�����ϲ��Ķ���ݹ�
% ��multFibonacci�����˷��ͺ� Fibonacci
% ��v5uniform������ͳ MATLAB? 5.0 �������ɺ���
% ��v5normal������ͳ MATLAB 5.0 �������ɺ���
% ��v4������ͳ MATLAB 4.0 ���ɺ���

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
%     repmatȫ����Replicate Matrix ��
%     ��˼�Ǹ��ƺ�ƽ�̾�����MATLAB�����һ��������
%     �﷨��B = repmat(A,m,n)��
%     ������ A ���� m��n �飬���� A ��Ϊ B ��Ԫ�أ�B �� m��n �� A ƽ�̶��ɡ�
%     B ��ά���� [size(A,1)*m, size(A,2)*n] ��
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