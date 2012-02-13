function plotDistro(mbDis, obDis, gmbDis, gobDis, fileName, title_, occPer, f, hours)

    totalDis = mbDis + obDis;
    gtotalDis = gmbDis + gobDis;
    fexist = exist('f');
    
    figure
    hold on;
    s = size(mbDis);
    x = 0:(s(2)-1);
    hold all;
    plot(x,mbDis);
    hold all;
    plot(x,obDis);
    hold all;
    plot(x,totalDis,'k');
    hold all;
    plot(x,gtotalDis*max(totalDis)/max(gtotalDis),'kp--');

    title([title_ ' : ' (num2str(round(occPer*10000)/100)) '% occupancy'],'FontSize',15);
    legend('Motorboat','Oarboat','Total','Goal distribution','Location','Best');
    xlabel('Trip duration (days)','FontSize',15);
    ylabel('Number of successful trips','FontSize',15);
    if max(totalDis) ~= 0, 
        axis([4 20 0 1.1*max(totalDis)]);
    end
    set(gca,'XTick',4:1:20,'FontSize',15);
    grid();
    saveas(gcf,[fileName '.png']);
    saveas(gcf,[fileName '.pdf']);
    close;
    
    if(fexist),
        figure(f);
        hold on;
        hold all;
        plot(x,totalDis,'DisplayName',[int2str(hours) 'h (' (num2str(round(occPer*10000)/100)) '%)']);
        hold all;
    end;