function [numCamps,mbHours,obHours,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfRead(fileName)
    [numCamps,mbHours,obHours,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer] = textread(fileName,'%d,%f,%f,%d,%d,%d,%f,%f','headerlines',1);
    iterationCounts = numCamps(1);
    numCamps = numCamps(2:end);
    mbHours = mbHours(2:end);
    obHours = obHours(2:end);
    mbTrips = mbTrips(2:end);
    obTrips = obTrips(2:end);
    totalTrips = totalTrips(2:end);
    optimalTripsTotal = optimalTripsTotal(2:end);
    occPer = occPer(2:end);