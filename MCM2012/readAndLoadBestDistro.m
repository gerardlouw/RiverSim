function [mbDis,obDis,gmbDis,gobDis,index] = readAndLoadBestDistro(filePrefix,gdisFile)
    gDis = dlmread(gdisFile,',');
    gmbDis = gDis(1,1:end);
    gobDis = gDis(2,1:end);
    [mbDis,obDis] = readDistro(filePrefix);
    [mbDis,obDis,index] = getBestDistro(mbDis,obDis, gmbDis, gobDis);