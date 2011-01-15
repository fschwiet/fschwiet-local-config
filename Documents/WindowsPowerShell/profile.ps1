cls

[System.Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, “Process”)
$env:editor = "notepad"

function includeEnvironmentPath {
	param ($path)
	
	if (-not (test-path $path)) {
		write-host "Missing path added to PATH variable: $path";
	}

    [System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + $path, "Process")
}

includeEnvironmentPath("C:\Program Files (x86)\Lua\5.1\bin");
includeEnvironmentPath("C:\msysgit\cmd");
includeEnvironmentPath("c:\src\local-config\imports\");

includeEnvironmentPath('C:\Program Files (x86)\SourceGear\DiffMerge');

$ndiff = "c:\src\gitndiff\gitndiff.ps1"

function luke
{
    . java -jar c:\src\luke\lukeall-1.0.1.jar
}

# framework references
function Get-FrameworkDirectory()
{
    $([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory())
}

set-alias installutil (join-path (& Get-FrameworkDirectory) "installutil.exe")
set-alias msbuild (join-path (& Get-FrameworkDirectory) "msbuild.exe")

set-alias linq-where where-object

. DebuggingLibrary.ps1
. gitutils.ps1
. miscutils.ps1
. EncryptDecryptString.PS1

function prompt {
    $path = ""
    $pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)
    if($pathbits.length -eq 1) {
    $path = $pathbits[0] + "\"
    } else {
    $path = $pathbits[$pathbits.length - 1]
    }
    $userLocation = $env:username + '@' + [System.Environment]::MachineName + ' ' + $path
    $host.UI.RawUi.WindowTitle = $userLocation
        Write-Host($userLocation) -nonewline -foregroundcolor Green
        
        if (isCurrentDirectoryGitRepository) {
            $status = gitStatus
            $currentBranch = $status["branch"]
            
            Write-Host(' [') -nonewline -foregroundcolor Yellow
            if ($status["ahead"] -eq $FALSE) {
                # We are not ahead of origin
                Write-Host($currentBranch) -nonewline -foregroundcolor Cyan
            } else {
                # We are ahead of origin
                Write-Host($currentBranch) -nonewline -foregroundcolor Red
            }
            Write-Host(' +' + $status["added"]) -nonewline -foregroundcolor Yellow
            Write-Host(' ~' + $status["modified"]) -nonewline -foregroundcolor Yellow
            Write-Host(' -' + $status["deleted"]) -nonewline -foregroundcolor Yellow
            
            if ($status["untracked"] -ne $FALSE) {
                Write-Host(' !') -nonewline -foregroundcolor Yellow
            }
            
            Write-Host(']') -nonewline -foregroundcolor Yellow
        }
        
    Write-Host('>') -nonewline -foregroundcolor Green
    return " "
}

import-module WebAdministration
import-module c:\src\local-config\imports\LINQ.psm1
Add-PSSnapin PSHostsFile

set-location c:\src


"  "
"Would you like to play a game of chess?  "
"  "
