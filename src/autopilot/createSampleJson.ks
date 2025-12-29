@LAZYGLOBAL OFF.

declare local outputPath to scriptPath():parent:combine("exampleFlightPlan.json").
declare local flightPlanData to lexicon().
createJson().
//copyPath(outputPath, path("0:/exampleFlightPlan.json")).

global function createJson {
    // Create a sample flight plan JSON structure.
    set flightPlanData["type"] to "rocket".
    set flightPlanData["description"] to "Sample flight plan for a rocket mission.".
    set flightPlanData["lastCompletedStep"] to -1.
    set flightPlanData["steps"] to list(
        lexicon(
            "action", "launch",
            "description", "Launch the rocket into a stable orbit.",
            "finalStage", 5,
            "targetOrbit", lexicon(
                "inc", 28.5,
                "e", 0.0,
                "sma", 700000.0,
                "argPe", 0.0,
                "lan", 0.0,
                "maEpoch", 0.0,
                "epoch", 0.0,
                "body", "earth"
            )
        ),
        lexicon(
            "action", "transfer",
            "description", "Perform a transfer burn to reach the target orbit.",
            "targetOrbit", lexicon(
                "inc", 0.0,
                "e", 0.0,
                "sma", 14000000.0,
                "argPe", 0.0,
                "lan", 0.0,
                "maEpoch", 0.0,
                "epoch", 0.0,
                "body", "earth"
            )
        ),
        lexicon(
            "action", "circularize",
            "description", "Circularize the orbit at the target altitude.",
            "limits", lexicon(
                "inc", lexicon(
                    "max", 1.0,
                    "min", 0.0
                ),
                "e", lexicon(
                    "max", 0.01,
                    "min", 0.0
                ),
                "period", lexicon(
                    "max", 14050000.0,
                    "min", 13950000.0
                )
            )
        )
    ).

    // Write the flight plan to a JSON file.
    open(outputPath):write(addons:json:stringify(flightPlanData)).
    print("Sample flight plan JSON created at: " + outputPath + ".").
}
