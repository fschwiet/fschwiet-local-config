cls

# ISPOWERSHELL may be checked by git scripts
[System.Environment]::SetEnvironmentVariable("ISPOWERSHELL", "true", "Process")

[System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + "C:\msysgit\msysgit\mingw\bin", "Process")
[System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + "C:\msysgit\msysgit\bin", "Process")
[System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + "C:\msysgit\msysgit\git", "Process")
[System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + "C:\src\git-commands", "Process")
[System.Environment]::SetEnvironmentVariable("PATH", $env:Path + ";" + "C:\Program Files (x86)\NUnit 2.5.3\bin\net-2.0", "Process")
[System.Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, “Process”)

$ndiff = "c:\src\gitndiff\gitndiff.ps1"

#  MSBuild usage:   & $msbuild ".\file.sln"
$msbuild = "C:\Windows\Microsoft.NET\Framework\v3.5\msbuild.exe"

# programmer's notepad
$pn = "c:\Program Files (x86)\Programmer's Notepad\pn"



"  "
"Would you like to play a game of chess?  "
"  "




. (Resolve-Path ~/Documents/WindowsPowershell/gitutils.ps1) 

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
