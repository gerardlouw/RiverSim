function plotIncCamp(afn,f, f2, title1, title2)
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
    if(exist('title1')),
        title(title1);
    end;
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
    if(exist('title2')),
        title(title2);
    end;
    ylabel('Campsite occupation percentage ( % )','FontSize',14);
    xlabel('Number of campsites ( Y )','FontSize',14);
    set(gca,'FontSize',14);
    grid();
    print (['inc_camp_count_occu_' afn], '-dpdf');
    print (['inc_camp_count_occu_' afn], '-dpng');
    close;
    
    figure(f2)
    hold all;
    plot(numCamps, occPer*100);
    