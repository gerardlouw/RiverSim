function plotHoursDistros(filePrefix, campCount, title_, mb)
    xFilePrefix = [filePrefix '_' int2str(campCount)];
    [mbDis obDis gmbDis gobDis iterations] = readDistro(xFilePrefix, [xFilePrefix '_dis.txt']);
    [numCamps,mbHours,obHours,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer] = dfReadAndAverage([filePrefix '_' int2str(campCount) '_df.txt']);
    
    %Average over iterations
    mbDis = reshapeAndAverageDis(mbDis,iterations);
    obDis = reshapeAndAverageDis(obDis,iterations);
    
    s = size(mbDis);
    for i = 1:s(1),
        if mb,
            title__ = [title_ '( ' int2str(mbHours(i)) 'h )'];
            fileName = [xFilePrefix '_mb' int2str(mbHours(i))];
        else
            title__ = [title_ '( ' int2str(obHours(i)) 'h )'];
            fileName = [xFilePrefix '_ob' int2str(obHours(i))];
        end;
        plotDistro(mbDis(i,1:end), obDis(i,1:end), gmbDis, gobDis, fileName, title__, occPer(i));
    end;
    