function plotIncCamp(afn, f)
    [numCamps,mbHours,obHours,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfReadAndMedian(['inc_camp_count_' afn '_df.txt']);

    figure
    hold all;
    plot(numCamps,mbTrips);
    hold all;
    plot(numCamps,obTrips);
    hold all;
    plot(numCamps,totalTrips);
    hold all;
    plot(numCamps,optimalTripsTotal,'k--');
    hold all;
    legend('Motorboat trips', 'Oarboat trips', 'Total trips', 'Theoretical throughput','Location','Best');
    ylabel('Trips','FontSize',14);
    xlabel('Number of campsites ( Y )','FontSize',14);
    set(gca,'FontSize',14);
    grid();
    print (['inc_camp_count_' afn], '-dpdf');
    print (['inc_camp_count_' afn], '-dpng');
    close;
    
    figure(f)
    hold all;
    plot(numCamps,totalTrips);
    
    figure
    plot(numCamps, occPer*100);
    ylabel('Campsite occupation percentage ( % )','FontSize',14);
    xlabel('Number of campsites ( Y )','FontSize',14);
    set(gca,'FontSize',14);
    grid();
    print (['inc_camp_count_occu_' afn], '-dpdf');
    print (['inc_camp_count_occu_' afn], '-dpng');
    close;
    