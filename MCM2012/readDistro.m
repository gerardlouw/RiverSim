function [mbDis,obDis,gmbDis,gobDis,iterations] = readDistro(filePrefix, gdisFile)
    mbDis = dlmread(strcat(filePrefix, '_mbf.txt'),',');
    obDis = dlmread([filePrefix '_obf.txt'],',');
    iterations = mbDis(1,1);
    mbDis = mbDis(2:end,1:end);
    obDis = obDis(2:end,1:end);
    
    gDis = dlmread(gdisFile,',');
    gmbDis = gDis(1,1:end);
    gobDis = gDis(2,1:end);