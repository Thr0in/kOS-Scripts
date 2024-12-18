print "Boot script loaded.".
if exists("0:/exe/autoUnfold") {
    copyPath("0:/exe/autoUnfold", "1:/autoUnfold").
} else {
    copyPath("0:/src/autoUnfold", "1:/autoUnfold").
}
wait until exists("1:/autoUnfold").
runpath("1:/autoUnfold").
deletePath("1:/boot/bootAutoUnfold").
