function OnClear()
    scite.StripShow("")
end

function StripDlg(args)

    local t = {}
    for k, v in string.gmatch(args, "(%w+)=([^ ]+)") do
        t[k] = v
    end
    if t["func"] then
        if not t["label1"] then t["label1"] = t["func"] end
        if not t["input1"] then t["input1"] = "[]" end
        if not t["button1"] then t["button1"] = "Go" end
        if not t["button2"] then t["button2"] = "Cancel" end
    end

    StripFunc = t["func"]

    if t["label2"] then
        if t["input2"] then
            scite.StripShow("'" .. t["label1"] .. "'" .. t["input1"] .. "(&" .. t["button1"] .. ")\n'"
                                .. t["label2"] .. "'" .. t["input2"] .. "(&" .. t["button2"] .. ")")
        else
            scite.StripShow("'" .. t["label1"] .. "'" .. t["input1"] .. "(&" .. t["button1"] .. ")\n'"
                                .. t["label2"] .. "'" .. t["input1"] .. "(&" .. t["button2"] .. ")")
        end
    elseif t["label1"] then
        scite.StripShow("'" .. t["label1"] .. "'" .. t["input1"] .. "(&" .. t["button1"] .. ")(&" .. t["button2"] .. ")'")
    end

    if StripFunc == "Python" or StripFunc == "Shell" or StripFunc == "Terminal" then
        local history = io.open(props["SciteUserHome"] .. "/SciTE-" .. StripFunc .. ".hist", "r")
        if history then 
            h = history:read("*a") 
            history:close()
        else 
            h = ""
        end
        scite.StripSetList(3, h)
    end

end

function OnStrip(control, change)
    if change == 1 then
        local val = {}
        for i=1,4 do
            if scite.StripValue(i) ~= "" then table.insert(val, scite.StripValue(i)) end
        end
        StripExec(val[1], val[2], control)
    end
end

function StripExec(val1, val2, c)

    local text = editor:GetSelText()
    if text == "" then text = editor:GetText() end

    if StripFunc == "Shell" or StripFunc == "Python" or StripFunc == "Terminal" then
--      add item to history (+):
        if h ~= "" and val1 ~= "" and c == 1 then
            if string.match(h, val1) == nil then
                local history = io.open(props["SciteUserHome"] .. "/SciTE-" .. StripFunc .. ".hist", "a")
                history:write(val1 .. '\n')
                history:close()
            end
        end
--      remove item from history (-):
        if h ~= "" and val1 ~= "" and c == 2 then
            local f = props["SciteUserHome"] .. "/SciTE-" .. StripFunc .. ".hist"
            local tt = {}
            for line in io.lines(f) do
                if line ~= val1 then table.insert(tt,line) end
            end
            local history = io.open(f, "w")
            for i, j in pairs(tt) do history:write(j .. '\n') end
            history:close()
        end
--      execute (Go):
        if val1 ~= "" and c == 4 then
            cmd = val1:gsub('\\', '\\\\'):gsub('"', '\\"')
            if StripFunc == "Python" then
                run = 'python -c "import sys,re,sets;scite=sys.stdin.read()\n' .. cmd .. '" 2>&1'
            else
--~                 run = 'bash -c "' .. cmd:gsub('$$', '\\$$') .. '" 2>&1'
                run = 'bash -c "' .. cmd .. '" 2>&1'
            end
            if StripFunc ~= "Terminal" then
                run = run .. ' << cvJZ1hqModtnAqBG\n' .. text .. '\ncvJZ1hqModtnAqBG'
            end
            local out = io.popen(run)
            print(out:read("*a"))
            out:close()
        end
--      (Cancel):
        if c == 5 then scite.StripShow("") end
    end

end
