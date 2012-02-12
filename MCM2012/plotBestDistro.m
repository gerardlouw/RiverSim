function plotBestDistro(filePrefix, numCamps, title_)
    nFilePrefix = [filePrefix '_' int2str(numCamps)];
    [mbDis,obDis,gmbDis,gobDis,index] = readAndLoadBestDistro(nFilePrefix,[filePrefix '.txt']);
    [numCamps,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfRead([nFilePrefix '_df.txt']);
    
    totalDis = mbDis + obDis;
    gtotalDis = gmbDis + gobDis;
    
    figure();
    hold on;
    title([title_ ' : ' (num2str(round(occPer(index)*10000)/100)) '% occupancy'],'FontSize',14);
    s = size(mbDis);
    x = 0:(s(2)-1);
    plot(x,mbDis,'r');
    plot(x,obDis,'b');
    plot(x,totalDis,'k');
    plot(x,gtotalDis*max(totalDis)/max(gtotalDis),'kp--');

    legend('Motorboat','Oarboat','Total','Goal distribution','Location','Best');
    xlabel('Trip duration (days)','FontSize',14);
    ylabel('Number of successful trips','FontSize',14);

    axis([4 20 0 1.1*max(totalDis)]);
    set(gca,'XTick',4:1:20,'FontSize',14);
    grid();
    print (nFilePrefix, '-dpdf');
    print (nFilePrefix, '-dpng');
    hold off;