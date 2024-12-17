// Execute the next and only Principia manoeuvre node
if hasnode {
    print("Executing next Principia manoeuvre node.").
    // Align to the next node
    wait until nextNode:eta < 60.
    initializeBurn().

    // Ullage
    wait until nextNode:eta < 10.
    set ship:control:fore to 1.

    // Burn
    wait until nextNode:eta < 0.1.
    excuteBurn().

    print("Deactivate RCS to disable the steering lock.").
    wait until not rcs.
    unlock throttle.
    unlock steering.
}

local function initializeBurn {
    kuniverse:timeWarp:cancelwarp().
    rcs on.
    declare local burnVector to nextNode:burnvector.
    lock steering to keepManoeuvreHeading(burnVector).
}

local function excuteBurn {
    declare local initialMass to ship:mass.
    declare local targetDeltaV to nextNode:deltaV:mag.
    lock throttle to 1.
    set ship:control:fore to 0.
    wait until getDeltaVSinceMass(initialMass) > targetDeltaV.
    lock throttle to 0.
    print("Manoeuvre executed. Spend " + getDeltaVSinceMass(initialMass) + "m/s of deltaV.").
}

local function keepManoeuvreHeading {
    parameter burnVector.
    if hasNode {
    set burnVector to nextNode:burnvector.
    }
    return burnVector.
}

local function getDeltaVSinceMass {
    parameter initialMass.
    declare local ispMetersPerSecond to getVesselIspMetersPerSecond().

    declare local currentDeltaV to ispMetersPerSecond * ln(initialMass / ship:mass).
    return currentDeltaV.
}

local function getVesselIspMetersPerSecond {
    declare local thrust to 0.
    declare local massFlow to 0.
    for engine in getActiveEngines() {
        set thrust to thrust + (engine:thrust * 1000.0). // Convert kN to N
        set massFlow to massFlow + (engine:massFlow * 1000.0). // Convert Mg/s to kg/s
    }
    if massFlow > 0 {
        return thrust / massFlow.
    }
    return 0.
}

local function getActiveEngines {
    declare local activeEngines to list().
    for engine in ship:engines {
        if engine:ignition {
            activeEngines:add(engine).
        }
    }
    return activeEngines.
}
