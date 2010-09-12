$targetdir = "\\Ardc2\Users\franks\Documents\WindowsPowerShell";

if (!(test-path $targetdir) ) {
    mkdir $targetdir
}

copy .\WindowsPowerShell\* $targetdir

.\deploy_home.ps1

