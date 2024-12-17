print "Boot script loaded.".
copyPath("0:/scripts/autoUnfold", "1:/autoUnfold").
wait until exists("1:/autoUnfold").
runpath("1:/autoUnfold").
deletePath("1:/boot/bootAutoUnfold").
