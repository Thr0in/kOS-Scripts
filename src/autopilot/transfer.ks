@LAZYGLOBAL OFF.

global function transferModule {
    return lexicon(
        "getBurnParameters", getBurnParameters@
    ).
}


local function getBurnParameters {
    declare parameter currentOrbit.
    declare parameter targetOrbit.

    // Placeholder implementation.
    print("Calculating burn parameters from current orbit to target orbit...").

    local normalCurrent is getNormalVector(currentOrbit:lan, currentOrbit:inclination).
    local normalTarget is getNormalVector(targetOrbit:lan, targetOrbit:inclination).
    local relativeInclination is vectorAngle(normalCurrent, normalTarget).
    local intersectionLine is vectorCrossProduct(normalCurrent, normalTarget).


}

local function getNormalVector {
    declare parameter lan.
    declare parameter inclination.

    local normal is v(
        sin(lan) * sin(inclination),
        cos(inclination),
        -cos(lan) * sin(inclination)
    ).
    return normal.
}
