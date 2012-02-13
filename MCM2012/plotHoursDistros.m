function plotHoursDistros(filePrefix, campCount, title_, mb)
    xFilePrefix = [filePrefix '_' int2str(campCount)];
    [mbDis obDis gmbDis gobDis iterations] = readDistro(xFilePrefix, [xFilePrefix '_dis.txt']);
    [numCamps,mbHours,obHours,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer] = dfReadAndAverage([filePrefix '_' int2str(campCount) '_df.txt']);
    
    %Average over iterations
    mbDis = reshapeAndAverageDis(mbDis,iterations);
    obDis = reshapeAndAverageDis(obDis,iterations);
    
    s = size(mbDis);
    f1 = figure();
    f2 = figure();
    
    for i = 1:s(1),
        if mb,
            h = mbHours(i);
            title__ = [title_ '( ' int2str(h) 'h )'];
            fileName = [xFilePrefix '_mb' int2str(h)];
            if(h >= 4 && mod(h,2) == 0 &&  h<= 14),
                plotDistro(mbDis(i,1:end), obDis(i,1:end), gmbDis, gobDis, fileName, title__, occPer(i),f1,h);
            else
                plotDistro(mbDis(i,1:end), obDis(i,1:end), gmbDis, gobDis, fileName, title__, occPer(i));
            end;
        else
            h = obHours(i);
            title__ = [title_ '( ' int2str(h) 'h )'];
            fileName = [xFilePrefix '_ob' int2str(h)];
            
            if(h >= 4 && mod(h,2) == 0 &&  h<= 14),
                plotDistro(mbDis(i,1:end), obDis(i,1:end), gmbDis, gobDis, fileName, title__, occPer(i),f2,h);
            else
                plotDistro(mbDis(i,1:end), obDis(i,1:end), gmbDis, gobDis, fileName, title__, occPer(i));
            end;
        end;
        
    end;
    if(mb),
    figure(f1);
    hold on;
    hold all;
    xlim([4 20]);
    set(gca,'FontSize',15);
    xlabel('Trip duration (days)','FontSize',15);
    ylabel('Number of successful trips','FontSize',15);
    legend('show');
    grid();
    saveas(gcf,[xFilePrefix '_mb_sum' '.pdf']);
    saveas(gcf,[xFilePrefix '_mb_sum' '.png']);
    else
    figure(f2);
    hold on;
    hold all;
    xlim([4 20]);
    set(gca,'FontSize',15);
    xlabel('Trip duration (days)','FontSize',15);
    ylabel('Number of successful trips','FontSize',15);
    legend('show');
    grid();
    saveas(gcf,[xFilePrefix '_ob_sum' '.pdf']);
    saveas(gcf,[xFilePrefix '_ob_sum' '.png']);
    end;
    