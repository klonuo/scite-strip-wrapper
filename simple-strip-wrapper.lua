function OnClear()
    scite.StripShow("")
end

function StripDlg(args)

    local t = {}
    for k, v in string.gmatch(args, "(%w+)=([^ ]+)") do t[k] = v end

    if t["func"] then
        StripFunc = t["func"]
        if not t["dlg"] then t["dlg"] = "'" .. t["func"] .. "'[](&OK)(&Cancel)" end
        _, w = t["dlg"]:gsub("['{}%(%)%[%]]", "")
        scite.StripShow(t["dlg"]:gsub('\\n', '\n'))
    else
        print("Invalid call")
    end

end

function OnStrip(control, change)
    if change == 1 then
        local val = {}
        for i = 0, w/2-1 do
            if scite.StripValue(i) ~= "" then table.insert(val, scite.StripValue(i)) end
        end
        StripExec(val[1], val[2], control)
    end
end

function StripExec(val1, val2, c)

    if editor:GetSelText() == "" then editor:SelectAll() end

    if StripFunc == "Lookfor" then
        local val = val1
        if val2 then val = val .. "', '" .. val2 end
        if c == 5 then 
            val = 'pydoc numpy.lookfor'
        else
            val = 'python -c "from numpy import lookfor; lookfor(\'' .. val .. '\')"'
        end
        local o = io.popen(val)
        print(o:read("*a"))
        o:close()
    end

end
