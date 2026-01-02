@LAZYGLOBAL OFF.

runOncePath(scriptPath():root:combine("lib/utils")).


declare parameter plan.

main().

local function main {
    print("Starting rocket autopilot...").

    from {local nextStep to plan:getNextStep().} until nextStep:action = "complete" step {set nextStep to plan:getNextStep().} do {
        print("Next flight plan step: " + nextStep:description + ".").

        switchBy(nextStep:action, lexicon(
            "launch", handleLaunchStep@:bind(nextStep),
            "transfer", handleTransferStep@:bind(nextStep),
            "circularize", {print("Circularize not yet implemented").}
        ), {print("Unknown action").}).

        plan:setLastCompletedStep(plan:getLastCompletedStep() + 1).
        plan:save().
        wait 5.
        set nextStep to plan:getNextStep().
    }
    print(plan:getNextStep():description).
    print("Flight plan complete. Rocket autopilot shutting down.").
}

local function handleLaunchStep {
    declare parameter step.
    print("Launch not yet implemented").
}

// Handle a transfer step in the flight plan.
// TODO: - Calculation of burn parameters by given target orbit and current orbit.
//       - Execution of the transfer burn.
//       - Finalization and verification of the transfer.
local function handleTransferStep {
    declare parameter step.
    print("Transfer not yet implemented").
}
