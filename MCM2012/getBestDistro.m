function [mbDis,obDis,index,min] = getBestDistro(mbDistro,obDistro, gmbDistro, gobDistro)
    s = size(mbDistro);
    min = 1;
    index = 1;
    for i=1:s(1),
        val = evalDistro(mbDistro(i,1:end), obDistro(i,1:end),gmbDistro, gobDistro);
        if val < min,
            min = val;
            index = i;
        end
    end
    mbDis = mbDistro(index,1:end);
    obDis = obDistro(index,1:end);
    