mbf = dlmread('mbf.txt',',');
obf = dlmread('obf.txt',',');

mb = mean(mbf,1);
ob = mean(obf,1);

total = mb + ob;

figure
hold on;
grid on;

plot(mb,'r');
plot(ob,'b');
plot(total,'k');
axis([4 20 0 max(total)]);
set(gca,'XTick',4:1:20)

hold off;

[numCamps,mbTrips,obTrips,totalTrips,optimalTripsTotal,occupationPercentage] = textread('num_camps_sf.txt','%d,%d,%d,%d,%f,%f','headerlines',1);

campSizes = 198;
runs = 20;

numCamps = median(reshape(numCamps, runs, campSizes), 1);
numCamps
mbTrips = median(reshape(mbTrips, runs, campSizes), 1);
obTrips = median(reshape(obTrips, runs, campSizes), 1);
totalTrips = median(reshape(totalTrips, runs, campSizes), 1);
optimalTripsTotal = median(reshape(optimalTripsTotal, runs, campSizes), 1);
occupationPercentage = median(reshape(occupationPercentage, runs, campSizes), 1);

for i=1:200
    %nummmCamps(i) = median(numCamps(i*10-9:i*10));
    %mbTripsss(i) = median(mbTripsss(i*10-9:i*10));
    %mbTripsss(i) = median(mbTripsss(i*10-9:i*10));
    %
end

figure;
hold on;
plot(numCamps, totalTrips, 'r', numCamps, optimalTripsTotal, 'b');
plot(numCamps,mbTrips,'g',numCamps,obTrips,'k');
hold off;

figure;
plot(numCamps,occupationPercentage);