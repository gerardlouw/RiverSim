function [dis] = reshapeAndAverageDis(dis, iterations)
    s = size(dis);
    dis2 = zeros(s(1)/iterations, s(2));
    for i = 1:s(2),
        dis2(1:end,i) = reshapeAndAverage(dis(1:end,i), iterations);
    end
    dis = dis2;