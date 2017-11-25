function idx = hb_findIdx( range, fullData )
% function idx = hb_findIdx( range, fullData )


idx = max(find( fullData < range(1)))+1:max(find(fullData<range(2)));

if length(idx)==0
    idx
    idx = 1:max(find(fullData<range(2)));
end


return

