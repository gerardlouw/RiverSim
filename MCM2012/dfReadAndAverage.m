function [numCamps,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfReadAndAverage(fileName)
    [numCamps,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfRead(fileName);
    numCamps = reshapeAndAverage(numCamps,iterationCounts);
    mbTrips = reshapeAndAverage(mbTrips,iterationCounts);
    obTrips = reshapeAndAverage(obTrips,iterationCounts);
    totalTrips = reshapeAndAverage(totalTrips,iterationCounts);
    optimalTripsTotal = reshapeAndAverage(optimalTripsTotal,iterationCounts);
    occPer = reshapeAndAverage(occPer,iterationCounts);