function plotDistro(mbDis, obDis, gmbDis, gobDis, fileName, title_, occPer)

    totalDis = mbDis + obDis;
    gtotalDis = gmbDis + gobDis;

    figure();
    hold on;
    title([title_ ' : ' (num2str(round(occPer*10000)/100)) '% occupancy'],'FontSize',14);
    s = size(mbDis);
    x = 0:(s(2)-1);
    plot(x,mbDis,'r');
    plot(x,obDis,'b');
    plot(x,totalDis,'k');
    plot(x,gtotalDis*max(totalDis)/max(gtotalDis),'kp--');

    legend('Motorboat','Oarboat','Total','Goal distribution','Location','Best');
    xlabel('Trip duration (days)','FontSize',14);
    ylabel('Number of successful trips','FontSize',14);

    if max(totalDis) ~= 0, 
        axis([4 20 0 1.1*max(totalDis)]);
    end
    set(gca,'XTick',4:1:20,'FontSize',14);
    grid();
    print (fileName, '-dpdf');
    print (fileName, '-dpng');
    hold off;
    close;