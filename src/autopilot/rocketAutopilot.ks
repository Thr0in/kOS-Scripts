@LAZYGLOBAL OFF.

runOncePath(scriptPath():root:combine("utils")).


declare parameter flightPlan.

main().

local function main {
    declare local nextStep to flightPlan:getNextStep().

    until nextStep:action = "complete". {
        print("Next flight plan step: " + nextStep:description + ".").

        switchBy(nextStep:action, lexicon(
            "launch", {print("Launch not yet implemented").},
            "transfer", handleTransferStep@:bind(nextStep),
            "circularize", {print("Circularize not yet implemented").}
        ), {print("Unknown action").}).

        flightPlan:setLastCompletedStep(flightPlan:getLastCompletedStep() + 1).
        flightPlan:save().
        wait 5.
        set nextStep to flightPlan:getNextStep().
    }
}

// Handle a transfer step in the flight plan.
// TODO: - Calculation of burn parameters by given target orbit and current orbit.
//       - Execution of the transfer burn.
//       - Finalization and verification of the transfer.
local function handleTransferStep {
    declare parameter step.
    print("Transfer not yet implemented").
}
