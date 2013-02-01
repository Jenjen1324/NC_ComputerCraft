function cls()
    term.clear();
    term.setCursorPos(1,1);
end

cls();
print("Staring up Home-Managment v1.5 ...");
rout = colors.combine();
redstone.setBundledOutput("back", rout);
quarryengine1 = false;
quarryengine2 = false;
quarrymenu = false;
reactormenu = false;
mdoor = false;
rdoor = false;
reactor = false;
menu = true;
sleep(2);
while(menu) do
    cls();
    print("Home-Managment v1.5");
    print("");
    print("");
    print("1: Quarry system");
    if (mdoor) then
        print("2: Close maintenance-door");
    else
        print("2: Open maintenance-door");
    end
        print("3: Reactor control");
    print("x: Exit");
    print("");
    action = read();
    print("");
    print("");
    
    if (action == "1") then
        quarrymenu = true;
        while (quarrymenu) do
            cls();
            print("Quarry system");
            print("");
            if (quarryengine1) then
                print("1: Turn off engine 1");
            else
                print("1: Turn on engine 1");
            end
            if (quarryengine2) then
                print("2: Turn off engine 2");
            else
                print("2: Turn on engine 2");
            end
            print("x: Go back");
            print("");
            action = read();
            if (action == "1") then
                if (quarryengine1) then
                    rout = colors.subtract(rout, colors.red);
                    redstone.setBundledOutput("back", rout);
                    quarryengine1 = false;
                else
                    rout = colors.combine(rout, colors.red);
                    redstone.setBundledOutput("back", rout);
                    quarryengine1 = true;
                end
            elseif (action == "2") then
                if (quarryengine2) then
                    rout = colors.subtract(rout, colors.yellow);
                    redstone.setBundledOutput("back", rout);
                    quarryengine2 = false;
                else
                    rout = colors.combine(rout, colors.yellow);
                    redstone.setBundledOutput("back", rout);
                    quarryengine2 = true;
                end
            elseif (action == "x") then
                quarrymenu = false;
                action = 0;
            end
        end
    elseif (action == "2") then
        if (mdoor) then
            rs.setOutput("left", true);
            mdoor = false;
        else
            rs.setOutput("left", false);
            mdoor = true;
        end
    elseif (action == "3") then
        reactormenu = true;
        while (reactormenu) do
            cls();
            print("Reactor System");
            print("")
            if (reactor) then
                print("1: Turn on nuclear reactor");
            else
                print("1: Turn off nuclear reactor");
            end
            if (rdoor) then
                print("2: Open reactor door");
            else
                print("2: Close reactor door");
            end
            print("x: Go back");
            print("");
            action = read();
            if (action == "1") then
                if not (reactor) then
                    print("Insert authentication card and press enter");
                    read();
                    if(disk.getLabel("bottom") == key) then
                        rout = colors.combine(rout, colors.orange);
                        redstone.setBundledOutput("back", rout);
                    else
                        print("WRONG KEYCARD");
                        disk.eject();
                    end
                else
                    rout = colors.substract(rout, colors.orange);
                    redstone.setBundledOutput("back", rout);
                end
            elseif (action == "2") then
                if (rdoor) then
                    rout = colors.subtract(rout, colors.blue);
                    redstone.setBundledOutput("back", rout);
                else
                    print("Insert authentication card and press enter");
                    read();
                    if(disk.getLabel("bottom") == key) then
                        rout = colors.combine(rout, colors.blue);
                        redstone.setBundledOutput("back", rout);
                    else
                        print("WRONG KEYCARD");
                        disk.eject();
                    end
                end
            elseif (action == "x") then
                reactormenu = false;
                action = 0;
            end
        end
    elseif (action == "x") then
        menu = false;
    end
end

