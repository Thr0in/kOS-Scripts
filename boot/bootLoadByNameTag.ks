declare parameter optionsString to CORE:tag.
declare local processedOptions to lexicon().

declare local currentPath to path("1:/boot"):combine(scriptPath():name).
if exists(currentPath) {
    print "Cleaning up boot script: " + currentPath + " ...".
    deletePath(currentPath).
}

print " ".

for option in optionsString:trim:split(" ") {
    if option:startsWith("--") {
        declare local keyValuePair to option:remove(0, 2):split("=").
        processedOptions:add(keyValuePair[0], choose keyValuePair[1] if keyValuePair:length > 1 else "").
    }
}

declare local activeOptions to "".
for key in processedOptions:keys {
    declare local value to choose ("=" + processedOptions[key] + " ") if processedOptions[key] <> "" else " ".
    set activeOptions to activeOptions + "--" + key + value.
}

print "> boot " + activeOptions.
print " ".

handleOptions(processedOptions).



// This function handles the options provided in the command line.
// It supports loading files and running scripts based on the provided options.
local function handleOptions {
    declare parameter options.

    if options:haskey("help") {
        print "Available options:".
        print "--load=<file1,file2,...> : Load specified files from 0:/".
        print "--run=<file> : Load and run the specified file from 0:/".
        print "--help : Show this help message.".
        return false.
    }

    if options:haskey("load") {
        declare local loadFiles to options["load"]:split(",").
        print "Loading " + loadFiles:length + " files...".
        print " ".
        for file in loadFiles {
            if not loadFile(path("0:/"):combine(file)) {
                return false.
            }
        }
    }

    if options:haskey("run") {
        return runFile(path("0:/"):combine(options["run"])).
    }

    return true.
}

// This function loads a file from 0:/ and copies it to 1:/ for execution.
// If the file does not exist, it prints an error message.
// Assures the file is copied successfully before proceeding.
local function loadFile {
    declare parameter filePath.
    if not exists(filePath) {
        print "File not found: " + filePath.
        print " ".
        return false.
    } else if path("1:/"):volume:freespace < open(filePath):size {
        print "Not enough space on 1:/ to copy " + filePath:name + ".".
        print "Available: " + path("1:/"):volume:freespace + ", Required: " + open(filePath):size.
        print " ".
        return false.
    }

    copyPath(filePath, "1:/").
    print "Copying file: " + filePath:name + " to 1:/".
    wait until exists("1:/" + filePath:name).
    print "File copied successfully: " + filePath:name.
    print " ".
    return true.
}

// This function runs the specified file from 1:/
// It assumes the file is a script that can be executed in the current environment.
local function runFile {
    declare parameter filePath.
    if not loadFile(filePath) {
        print "Failed to load file: " + filePath:name + ". Cannot run it.".
        return false.
    }

    print "Running file: " + filePath:name.
    runpath("1:/" + filePath:name).
    return true.
}
