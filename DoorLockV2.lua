print("======================================")
print("Starting: DoorLock v2")
print("======================================")
print("")
dofile "password"
ROut = "left"
DiskOut = "back"
DiskIn = "bottom"
EndlessLoop = true
while EndlessLoop do
	term.clear()
	term.setCursorPos(1,1)
	print("======================================")
	print("DoorLock v1 Started")
	print("Insert Keycard for actions")
	print("======================================")
	print("")
	if disk.isPresent(DiskOut) == true then
        DPwd = fs.open("disk/key", "r")
        
		if disk.getLabel(DiskOut) == key then
            disk.eject(DiskOut)
            redstone.setOutput(ROut, true)
            sleep(5)
               redstone.setOutput(ROut, false)
        else
            disk.eject(DiskOut)
        end
    end
    if disk.isPresent(DiskIn) then
        if disk.getLabel(DiskIn) == key then
            disk.eject(DiskIn)
            print("Actions:")
            print("")
            print("1: Termiante DoorLock")
            print("2: Change Password")
            print("3: Create a new Keycard")
            print("4: Open the Door")
            print("")
            type "Choose Action: "
            AInput = read()
            print("")
            print("")
            if AInput == "1" then
                EndlessLoop = false
            elseif AInput == "2" then
                PFile = fs.open("password","w")
                type "Type your new password: "
                PInput = read()
				
                PFile.write("key = \"")
                PFile.write(PInput)
                PFile.write("\"")
                PFile.close()
                ActionLoop2 = true
                print("Insert your Keycard!")
                while ActionLoop2 == true do
                    if disk.isPresent(DiskIn) then
                        disk.setLabel(DiskIn, PInput)
                        disk.eject(DiskIn)
                        dofile "password"
                        ActionLoop2 = false
                    end
                    sleep(0.5)
                end
            elseif AInput == "3" then
                print("Insert new disk")
                ActionLoop3 = true
                while ActionLoop3 == true do
                    if disk.isPresent(DiskIn) then
                        disk.setLabel(DiskIn, key)
                        disk.eject(DiskIn)
                        ActionLoop3 = false
					else
                        sleep(0.5)
					end
                end
            elseif AInput == "4" then
                rs.setOutput(ROut, true)
                sleep(5)
                rs.setOutput(ROut, false)
            end
        else
            disk.eject(DiskIn)
        end
	end
	sleep(0.2)
end