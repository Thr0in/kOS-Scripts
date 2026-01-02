copyPath("0:/src/lib/utils", "1:/lib/utils").
copyPath("0:/src/autopilot", "1:/autopilot").


wait until exists("1:/autopilot/autopilotMain").

runPath("autopilot/autopilotMain").
