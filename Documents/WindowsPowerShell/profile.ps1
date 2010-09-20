cls

[System.Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, “Process”)

function includeEnvironmentPath {
	param ($path)
	
	if (-not (test-path $path)) {
		write-host "Missing path added to PATH variable: $path";
	}

    [System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + $path, "Process")
}

includeEnvironmentPath("C:\Program Files (x86)\Lua\5.1\bin");
includeEnvironmentPath("C:\msysgit\cmd");
includeEnvironmentPath("C:\src\git-commands");

$nunitpath = (get-item 'C:\Program Files (x86)\NUnit 2.*\bin\*').fullname
includeEnvironmentPath($nunitpath);
includeEnvironmentPath('C:\Program Files (x86)\SourceGear\DiffMerge');

$ndiff = "c:\src\gitndiff\gitndiff.ps1"

function luke
{
    . java -jar c:\src\luke\lukeall-1.0.1.jar
}

#  MSBuild usage:   & $msbuild ".\file.sln"
$msbuild = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"

# programmer's notepad
$pn = "c:\Program Files (x86)\Programmer's Notepad\pn"

# framework references
function Get-FrameworkDirectory()
{
    $([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory())
}

set-alias installutil (join-path (& Get-FrameworkDirectory) "installutil.exe")
set-alias msbuild (join-path (& Get-FrameworkDirectory) "msbuild.exe")

. DebuggingLibrary.ps1
. gitutils.ps1
. miscutils.ps1

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

set-location c:\src


"  "
"Would you like to play a game of chess?  "
"  "
