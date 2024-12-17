wait until ship:unpacked.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
print "Boot script loaded.".
copyPath("0:/scripts/helloWorld", "1:/helloWorld").
wait until exists("1:/helloWorld").
runpath("1:/helloWorld").
