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

    if StripFunc == "Lookfor" then
        local val = val1
        if val2 then val = val .. "', '" .. val2 end
        if c == 5 then
            local o = io.popen('pydoc numpy.lookfor')
            print(o:read("*a"))
            o:close()
        else
            local o = io.popen('python -c "from numpy import lookfor; lookfor(\'' .. val .. '\')"')
            print(o:read("*a"))
            o:close()
        end
    end
end
