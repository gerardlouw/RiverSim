function [mbDistro obDistro] = readDistro(filePrefix)
    mbDistro = dlmread(strcat(filePrefix, '_mbf.txt'),',');
    obDistro = dlmread([filePrefix '_obf.txt'],',');
    mbDistro = mbDistro(2:end,1:end);
    obDistro = obDistro(2:end,1:end);