param ($target = "")

if (-not $target -or -not $target.endswith("WindowsPowerShell")) {

	write-host "The parameter target did not indicate where the files should be deployed."
	write-host "This directory will be wiped.  For safety, only values ending in 'WindowsPowerShell' are accepted."
}

if (!(test-path $target) ) {
    mkdir $target
}

rm (join-path $target *) -recurse

copy .\contents\* $target -rec


"to install posh-git: `n 1) clone https://github.com/dahlbyk/posh-git.git`n 2) Run .\install.ps1" | write-host -fore green