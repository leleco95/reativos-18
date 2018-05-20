function string.split(s, p)
    local stringSplit = {}
    while s ~= '' and s:find(p) ~= nil do
        local finish = s:find(p)
        local cut = s:sub(1, finish-1)
        if cut ~= '' then
            table.insert(stringSplit, cut)
        end
        s = s:sub(finish+1)
    end
    if s ~= '' then
        table.insert(stringSplit, s)
    end
    return stringSplit
end