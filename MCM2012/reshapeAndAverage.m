function result = reshapeAndAverage(array, iterations)
    result = mean(reshape(array, iterations, numel(array)/iterations), 1);