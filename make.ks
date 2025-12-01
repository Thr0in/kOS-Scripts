// Description: This script compiles all files in a given directory to the "0:/bin" directory.
// The compiled files are named the same as the source files using the ".ksm" extension.
// Accepts a single file or a directory as a parameter.
// If no parameter is given, the default directory is "0:/src".
// Usage: runpath(make, "0:/src") or runpath(make, "0:/src/helloWorld.ks").
// Author: Throin

parameter sourceDirectory to "0:/src", targetDirectory to "0:/bin".
declare local oldDirectory to path().

if exists(sourceDirectory) {
    switch to path(sourceDirectory):volume.
    print("Switched to " + path(sourceDirectory):volume:name).

// Get all files in the given directory or the single file.
    declare local files to list().
    if open(sourceDirectory):isfile {
        files:add(open(sourceDirectory):name).
        cd(path(sourceDirectory):parent).
        print("Changed to " + path(sourceDirectory):parent).
        print("Found file " + open(sourceDirectory):name).
    } else {
        cd(sourceDirectory).
        print("Changed to " + sourceDirectory).
        list files in f.
        for file in f {
            if file:extension = "ks" or not open(file):isfile {
                files:add(file:name).
            }
        }
        print("Found " + files:length + " files").
    }
    print(" ").

// Compile all files in the list.
    declare numberOfCompiledFiles to 0.
    for file in files {
        if open(file):isfile {
            declare local compiledFile to path(targetDirectory):combine(file + "m").
            compile file to compiledFile.

            if open(file):size <= open(compiledFile):size {
                deletepath(compiledFile).
                print(" - File " + file + " is smaller than compiled file " + file + "m" + ".").
                print("   Deleted compiled file.").
            } else {
                print(" - Compiled " + file + " to " + compiledFile + ".").
                print("   Size: " + open(compiledFile):size + " bytes.").
                set numberOfCompiledFiles to numberOfCompiledFiles + 1.
            }
        } else {
            runPath("0:/make.ks", path(sourceDirectory):combine(file), path(targetDirectory):combine(file)).
        }
    }
    print(" ").
    print("Compiled " + numberOfCompiledFiles + " files").
    print(" ").
} else {
    print("File or directory not found").
}

switch to oldDirectory:volume.
cd(oldDirectory).
print("Switched back to " + oldDirectory).
