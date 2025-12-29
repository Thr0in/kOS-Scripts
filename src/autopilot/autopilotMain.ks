@LAZYGLOBAL OFF.

runOncePath(scriptPath():parent:combine("flightPlan")).


declare parameter flightPlanPath is scriptPath():parent:combine("flightPlan.json").

declare local plan to FlightPlan(flightPlanPath).
main().


// Entry point
// Executes the provided flight plan based on its type.
// Currently supports only 'rocket' type flight plans.
local function main {
    if not plan:isValid() {
        return.
    }

    print("Loaded flight plan of type: " + plan:getType() + ".").
    print(plan:getDescription()).

    if plan:getType() = "rocket" {
        runPath(scriptPath():parent:combine("rocketAutopilot"), plan).
    }

}
