
param(
    $configPath = "C:\Users\" + $env:username + "\AppData\Roaming\Sublime Text 2\Packages\" + $env:username,
    [switch] $updateGitRepo = $false,
    $filesToExclude = @("Package Control.sublime-settings"),
    $packagePath = ".\packages"
    )

$sourceConfigPath = (resolve-path ".\configs")
$targetConfigPath = $configPath

$sourcePackagePath = (resolve-path ".\packages")
$targetPackagePath = 'C:\Program Files\Sublime Text 2\Pristine Packages'

if ($updateGitRepo) {
    $sourceConfigPath,$targetConfigPath = $targetConfigPath,$sourceConfigPath
    $sourcePackagePath,$targetPackagePath = $targetPackagePath,$sourcePackagePath
}

function attemptCopy($file, $t) {

    $isExcluded = $filesToExclude | ? { $file.fullname.tolower().endswith($_.tolower())}

    if (-not $isExcluded) {
        ".. including $($file.name)" | write-host
        cp $file.fullname $t
    } else {
        ".. skipping $($file.name)" | write-host
    }
}

"copying from $sourceConfigPath to $targetConfigPath"

gci $sourceConfigPath "*.sublime-settings" | % { attemptCopy $_ $targetConfigPath }

if (-not $updateGitRepo) {
    "copying from $sourcePackagePath to $targetPackagePath"

    gci $sourcePackagePath "*.sublime-package" | % { attemptCopy $_ $targetPackagePath }
}

if (-not $updateGitRepo) {
    "if you meant to write to the current machine's config, use -updateGitRepo after reverting what you just imported from config" | write-host -fore yellow
} else {
    "where any module configs copied?  maybe they should be skipped" | write-host -fore yellow
}

