clear;
close all;

% Process increasing camp sites data

[numCamps,mbTrips,obTrips,totalTrips,optimalTripsTotal,occPer,iterationCounts] = dfReadAndAverage('inc_camp_count_df.txt');

figure
hold on;
title('Number of Trips vs Campsites');
plot(numCamps,mbTrips,'r');
plot(numCamps,obTrips,'b');
plot(numCamps,totalTrips,'k');
plot(numCamps,optimalTripsTotal,'g');
grid();
hold off;

figure
title('Occ per');
plot(numCamps, occPer);

% Process distrobutions

for i=45:45:225,
    plotBestDistro('linp_dis', i, ['Positive Linear ( Y = ' int2str(i) ' )']);
    plotBestDistro('linn_dis', i, ['Negative Linear ( Y = ' int2str(i) ' )']);
    plotBestDistro('normal_dis', i, ['Gaussian ( Y = ' int2str(i) ' )']);
    plotBestDistro('uni_dis', i, ['Uniform ( Y = ' int2str(i) ' )']);
    plotBestDistro('sin_dis', i, ['Sinusoidal ( Y = ' int2str(i) ' )']);
end
