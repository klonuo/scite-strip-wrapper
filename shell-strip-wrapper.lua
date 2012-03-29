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

    if StripFunc == "Shell" or StripFunc == "Python" then
        local history = io.open(props["SciteUserHome"] .. "/SciTE-" .. StripFunc .. ".hist", "r")
        if history then 
            h = history:read("*a") 
            history:close()
        else 
            h = ""
        end
        scite.StripSetList(1, h)
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

    if StripFunc == "Shell" or StripFunc == "Python" then
--      execute:
        if val1 ~= "" and c == 2 then
            cmd = val1:gsub('\\', '\\\\'):gsub('"', '\\"')
            if StripFunc == "Python" then
                run = 'python -c "import sys,re,sets;scite=sys.stdin.read()\n' .. cmd
            else
                run = 'sh -c "' .. cmd:gsub('$$', '\\$$')
            end
            local out = io.popen(run .. '" 2>&1 << cvJZ1hqModtnAqBG\n' .. editor:GetSelText() .. '\ncvJZ1hqModtnAqBG')
            print(out:read("*a"))
            out:close()
        end
--      history:
        if h ~= "" and val1 ~= "" and c > 2 then
            local f = props["SciteUserHome"] .. "/SciTE-" .. StripFunc .. ".hist"
            local tt = {}
            for line in io.lines(f) do
                if line ~= val1 then table.insert(tt, line) end
            end
            if c == 3 then table.insert(tt, val1) end
            local history = io.open(f, "w")
            for i, j in pairs(tt) do history:write(j .. '\n') end
            history:close()
        end
    end

end
