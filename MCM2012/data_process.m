clear;
close all;

% Process increasing camp sites data
f = figure();
plotIncCamp('age',f);
plotIncCamp('wage',f);
plotIncCamp('mov',f);
plotIncCamp('rand',f);
figure(f);
hold all;
legend('Age', '{\Pi}_1', '{\Pi}_2', 'Random');
ylabel('Trips','FontSize',14);
xlabel('Number of campsites ( Y )','FontSize',14);
set(gca,'FontSize',14);
grid();
print ('inc_camp_count', '-dpdf');
print ('inc_camp_count', '-dpng');

% Process distrobutions

for i=45:45:225,
    plotBestDistro('linp_dis', i, ['Positive Linear (Y = ' int2str(i)]);
    plotBestDistro('linn_dis', i, ['Negative Linear (Y = ' int2str(i)]);
    plotBestDistro('normal_dis', i, ['Gaussian (Y = ' int2str(i)]);
    plotBestDistro('uni_dis', i, ['Uniform (Y = ' int2str(i)]);
    plotBestDistro('sin_dis', i, ['Sinusoidal (Y = ' int2str(i)]);
end

for i=45:45:225,
    plotHoursDistros('sens_analyis_mb_hours', i, 'Motorboat distribution',1);
    plotHoursDistros('sens_analyis_ob_hours', i, 'Oarboat distribution',0);
end
