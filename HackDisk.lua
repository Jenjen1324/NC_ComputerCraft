Loop = true
while Loop == true do
term.clear()
term.setCursorPos(1,1)
print("==================================")
print("HackDisk v1 started!")
print("==================================")
print("")
print("")
print("Actions:")
print("")
print("1: Get to Terminal")
print("2: Turn on redstone-signals")
print("3: Turn off redstone-signals")
print("4: Eject and run a program")
print("")
Action = read()
print("")
print("")
if Action == "1" then
	print("Entering terminal...")
    Loop = false
elseif Action == "2" then
    print("Choose direction:")
    RRed = read()
    rs.setOutput(RRed, true)
elseif Action == "3" then
    print("Choose direction:")
    RRed = read()
    rs.setOutput(RRed, false)
elseif Action == "4" then
    print("Choose program ([-no] for no program)")
    Prog = read()
    print("Choose disk position")
    DiskPos = read()
    if Prog == "-no" then
        disk.eject(DiskPos)
    else
        disk.eject(DiskPos)
        dofile(Prog)
    end
    sleep(1)
end

end -- End while Loop