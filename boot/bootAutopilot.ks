copyPath("0:/src/utils", "1:/utils").
copyPath("0:/src/autopilot", "1:/autopilot").


wait until exists("1:/autopilot/autopilotMain").

runPath("autopilot/autopilotMain").
