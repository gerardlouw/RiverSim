function result = reshapeAndMedian(array, iterations)
    result = median(reshape(array, iterations, numel(array)/iterations), 1);