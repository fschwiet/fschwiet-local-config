$targetdir = "$env:USERPROFILE\Documents\WindowsPowerShell"

if (!(test-path $targetdir) ) {
    mkdir $targetdir
}

copy .\WindowsPowerShell\* $targetdir
