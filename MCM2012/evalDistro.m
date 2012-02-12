function [value] = evalDistro(mbDis, obDis, gmbDis, gobDis) 
    mbDis = mbDis ./ sum(mbDis);
    obDis = obDis ./ sum(obDis);
    value = 0.5 * sum((gmbDis - mbDis).^2) / (sum(mbDis.^2) + sum(gmbDis.^2)) + 0.5 * sum((gobDis - obDis).^2) / (sum(obDis.^2) + sum(gobDis.^2));