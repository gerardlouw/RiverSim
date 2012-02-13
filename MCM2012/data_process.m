clear;
close all;

% Process increasing camp sites data

[numCamps,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfReadAndAverage('inc_camp_count_df.txt');

figure
hold on;
plot(numCamps,mbTrips,'r');
plot(numCamps,obTrips,'b');
plot(numCamps,totalTrips,'k');
plot(numCamps,optimalTripsTotal,'k--');
legend('Motorboat trips', 'Oarboat trips', 'Total trips', 'Theoretical throughput','Location','Best');
ylabel('Trips','FontSize',14);
xlabel('Number of campsites ( Y )','FontSize',14);
set(gca,'FontSize',14);
grid();
print ('inc_camp_count', '-dpdf');
print ('inc_camp_count', '-dpng');
hold off;

figure
plot(numCamps, occPer*100);
ylabel('Campsite occupation percentage ( % )','FontSize',14);
xlabel('Number of campsites ( Y )','FontSize',14);
set(gca,'FontSize',14);
grid();
print ('inc_camp_count_occu', '-dpdf');
print ('inc_camp_count_occu', '-dpng');


% Process distrobutions

for i=45:45:225,
    plotBestDistro('linp_dis', i, ['Positive Linear ( Y = ' int2str(i) ' )']);
    plotBestDistro('linn_dis', i, ['Negative Linear ( Y = ' int2str(i) ' )']);
    plotBestDistro('normal_dis', i, ['Gaussian ( Y = ' int2str(i) ' )']);
    plotBestDistro('uni_dis', i, ['Uniform ( Y = ' int2str(i) ' )']);
    plotBestDistro('sin_dis', i, ['Sinusoidal ( Y = ' int2str(i) ' )']);
end
