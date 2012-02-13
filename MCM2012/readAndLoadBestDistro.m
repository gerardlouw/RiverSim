function [mbDis,obDis,gmbDis,gobDis,index,val] = readAndLoadBestDistro(filePrefix,gdisFile)
    
    [mbDis,obDis,gmbDis,gobDis] = readDistro(filePrefix,gdisFile);
    [mbDis,obDis,index,val] = getBestDistro(mbDis,obDis, gmbDis, gobDis);