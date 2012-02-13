function plotBestDistro(filePrefix, numCamps, title_)
    nFilePrefix = [filePrefix '_' int2str(numCamps)];
    [mbDis,obDis,gmbDis,gobDis,index,val] = readAndLoadBestDistro(nFilePrefix,[filePrefix '.txt']);
    [numCamps,mbHours,obHours,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer] = dfRead([nFilePrefix '_df.txt']);
    plotDistro(mbDis, obDis, gmbDis, gobDis, nFilePrefix, [title_ ' \delta=' num2str(val) ')'], occPer(index));