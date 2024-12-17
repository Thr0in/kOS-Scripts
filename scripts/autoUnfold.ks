// Extend all deployable antennas when the ship reaches 140km altitude.
print("Waiting for ship to reach 140km altitude...").
wait until ship:altitude > 140000.
print("Ship has reached 140km altitude.").
print("Unfolding antennas...").
for moduleAntenna in ship:modulesnamed("ModuleDeployableAntenna") {
    if moduleAntenna:hasaction("Antenne ausfahren") {
        moduleAntenna:doaction("Antenne ausfahren", true).
        print(moduleAntenna:part:title + " unfolded.").
    } else {
        print(moduleAntenna:part:title + " cannot be unfolded.").
    }
}
deletePath("1:/autoUnfold").
copyPath("0:/scripts/executePrcpMan", "1:/executePrcpMan").
