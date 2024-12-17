@LAZYGLOBAL off.

print "Hello World!".
wait 1.
print "This is a kOS script.".
countDown.

declare local function countDown {
    from {declare local i to 0.} until i = 10 step {set i to i + 1.} do {
    print "This is line " + (i + 1) + " of the script.".
    wait 1.
    }
}
