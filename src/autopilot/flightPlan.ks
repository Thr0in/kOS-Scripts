@LAZYGLOBAL OFF.

// FlightPlan class
// Encapsulates a flight plan and provides validation methods.
global function FlightPlan {
    declare parameter flightPlanFile.

    declare local this to lexicon().
    declare local flightPlanData to addons:json:parse(open(flightPlanFile):readall():string).
    declare local jsonPath to path(flightPlanFile).


    // Validates a given flight plan.
    // Returns true if valid, false otherwise.
    set this["isValid"] to {
        if not flightPlanData:istype("lexicon") {
            print("Invalid flight plan format. Expected 'lexicon' type.").
            return false.
        }
        if not flightPlanData:haskey("type") {
            print("Flight plan missing 'type' key.").
            return false.
        }
        return true.
    }.


    set this["getType"] to {
        return flightPlanData["type"].
    }.

    set this["setType"] to {
        declare parameter type.
        set flightPlanData["type"] to type.
    }.


    set this["getDescription"] to {
        return choose flightPlanData["description"] if flightPlanData:haskey("description") else "No description provided.".
    }.

    set this["setDescription"] to {
        declare parameter description.
        set flightPlanData["description"] to description.
    }.


    set this["getLastCompletedStep"] to {
        return choose flightPlanData["lastCompletedStep"] if flightPlanData:haskey("lastCompletedStep") else -1.
    }.

    set this["setLastCompletedStep"] to {
        declare parameter stepIndex.
        if (stepIndex < this:getLastCompletedStep() or this:getSteps():length() <= stepIndex) {
            print("Invalid step index for last completed step.").
            return -1.
        }
        set flightPlanData["lastCompletedStep"] to stepIndex.
        return 0.
    }.


    set this["getSteps"] to {
        return choose flightPlanData["steps"] if flightPlanData:haskey("steps") else list().
    }.

    set this["setSteps"] to {
        declare parameter steps.
        if this:getLastCompletedStep() >= 0 {
            print("Cannot set steps after execution has started.").
            return -1.
        }
        set flightPlanData["steps"] to steps.
        return 0.
    }.

    set this["getNextStep"] to {
        declare local nextStepIndex to this:getLastCompletedStep() + 1.
        if nextStepIndex >= this:getSteps():length() {
            return lexicon("action", "complete", "description", "All steps completed." ). // Indicate completion
        }
        return this:getSteps()[nextStepIndex].
    }.


    set this["getPath"] to {
        return jsonPath.
    }.

    set this["setPath"] to {
        declare parameter newPath.
        set jsonPath to path(newPath).
    }.


    // Saves the current flight plan to its path.
    // Returns 0 on success, -1 on failure.
    set this["save"] to {
        if jsonPath = -1 {
            print("Cannot save flight plan: no valid path specified.").
            return -1.
        }
        declare local fileContent to addons:json:stringify(flightPlanData).
        declare local file to open(jsonPath).

        if ((file:istype("boolean") and not file) or jsonPath:volume:freespace + file:size() < fileContent:length()) {
            print("Insufficient space to save flight plan.").
            return -1.
        }

        file:clear().
        file:write(fileContent).
        return 0.
    }.


    return this.
}
