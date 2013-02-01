-- note monitor limit is 19

m = ""

function getPeri()
    local sides = {"top","bottom","left","right","front","back"}
    for i = 1,6,1 do
        if peripheral.isPresent(sides[i]) then
            if peripheral.getType(sides[i]) == "monitor" then
                m = peripheral.wrap(sides[i])
            elseif peripheral.getType(sides[i]) == "modem" then
                rednet.open(sides[i])
            end
        end
    end
end

getPeri()

m.clear()
m.setCursorPos(1,1)


lines = { }
computers = { }
names = { }
iLine = 0
running = true


    

function clearTerm()
    term.clear()
    term.setCursorPos(1,1)
end

function clearMon()
    m.clear()
    m.setCursorPos(1,1)
end

function loadConfig()
    --[[ local i = 1
    local l
    local f = io.open("data/computers.txt","r")
    while true do
        l = f.read(f)
        if not l then break end
        coputers[i] = l
        i = i + 1
    end
    i = 1
    f = io.open("data/names.txt","r")
    while true do
        l = f.read(f)
        if not l then break end
        names[i] = l
        i = i + 1
    end
    f.close() ]]--
    i = 1
    f = io.open("data/log.txt","r")
    while true do
        l = f.read(f)
        if not l then break end
        lines[i] = l
        i = i + 1
    end
    iLine = i + 1
    f.close()
end

function saveConfig()
    local f = io.open("data/log.txt","w")
    i = 1
    while true do
        if lines[i] == nil then
            break
        end
        f:write(lines[i].."\n")
        i = i + 1
    end
    f.close()
end

function putScreen(startLine)
    clearMon()
    for i = 1,19,1 do
        m.setCursorPos(1,i)
        m.write(lines[startLine])
    end
end

function putTerm(startLine)
    clearTerm()
    print("Printing to terminal")
    for i = 1,19,1 do
        term.setCursorPos(1,i)
        term.write(lines[startLine])
    end
end

function wait()
    event, sender, message = os.pullEvent()
    if event == "rednet_message" then
        if message == "cmd_monitorConfig" then
            putScreen(iLine - 19)
        else
            lines[iLine] = textutils.formatTime(os.time(),true).." "..sender..": "..message
            if iLine < 19 then
                putTerm(iLine)
            else
                putTerm(iLine - 19)
            end
            iLine = iLine + 1
            saveConfig()
        end
    elseif event == "key" then
        running = false
    end
end

while running do
    wait()
end