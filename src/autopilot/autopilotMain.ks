@LAZYGLOBAL OFF.

runOncePath(scriptPath():parent:combine("flightPlan")).


declare parameter flightPlanPath is scriptPath():parent:combine("flightPlan.json").

declare local flightPlan to FlightPlan(flightPlanPath).
main().


// Entry point
// Executes the provided flight plan based on its type.
// Currently supports only 'rocket' type flight plans.
local function main {
    if not flightPlan:isValid() {
        return.
    }

    print("Loaded flight plan of type: " + flightPlan:getType() + ".").
    print(flightPlan["description"]).

    if flightPlan:getType() = "rocket" {
        runPath(path("rocketAutopilot"), flightPlan).
    }

}
