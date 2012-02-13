clear;
close all;

% Process increasing camp sites data
f11 = figure();
f12 = figure();
plotIncCamp('wage',f11,f12);
plotIncCamp('mov',f11,f12);
plotIncCamp('age',f11,f12);
plotIncCamp('rand',f11,f12);

f21 = figure();
f22 = figure();
plotIncCamp('wage_inf',f21,f22);
plotIncCamp('mov_inf',f21,f22);
plotIncCamp('age_inf',f21,f22);
plotIncCamp('rand_inf',f21,f22);

figure(f11);
hold all;
set(gca,'FontSize',15);
legend('{\Phi}_1', '{\Phi}_2', '{\Phi}_3', 'Random', 'Location', 'Best');
ylabel('Trips','FontSize',15);
xlabel('Number of campsites (Y)','FontSize',15);
grid();
saveas(gcf,'inc_camp_count_sum.pdf');
saveas(gcf,'inc_camp_count_sum.png');

figure(f12);
hold all;
set(gca,'FontSize',15);
legend('{\Phi}_1', '{\Phi}_2', '{\Phi}_3', 'Random', 'Location', 'Best');
ylabel('Campsite occupation percentage (%)','FontSize',15);
xlabel('Number of campsites (Y)','FontSize',15);
grid();
saveas(gcf,'inc_camp_count_occu_sum.pdf');
saveas(gcf,'inc_camp_count_occu_sum.png');


figure(f21);
hold all;
set(gca,'FontSize',15);
legend('{\Phi}_1', '{\Phi}_2', '{\Phi}_3', 'Random', 'Location', 'Best');
ylabel('Trips','FontSize',15);
xlabel('Number of campsites (Y)','FontSize',15);
grid();
saveas(gcf,'inc_camp_count_sum_inf.pdf');
saveas(gcf,'inc_camp_count_sum_inf.png');

figure(f22);
hold all;
set(gca,'FontSize',15);
legend('{\Phi}_1', '{\Phi}_2', '{\Phi}_3', 'Random', 'Location', 'Best');
ylabel('Campsite occupation percentage (%)','FontSize',15);
xlabel('Number of campsites (Y)','FontSize',15);
grid();
saveas(gcf,'inc_camp_count_occu_sum_inf.pdf');
saveas(gcf,'inc_camp_count_occu_sum_inf.png');

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
