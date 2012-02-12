function result = reshapeAndAverage(array, iterations)
    result = median(reshape(array, iterations, numel(array)/iterations), 1);