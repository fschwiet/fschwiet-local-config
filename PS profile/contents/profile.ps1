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

if (-not (get-command jav[a])) {
    $typicalJavaPath = "C:\Program Files (x86)\Java\jre6\bin";
    if (test-path $typicalJavaPath) {
        includeEnvironmentPath($typicalJavaPath);
    }
}

if (test-path 'C:\Program Files (x86)\SourceGear\DiffMerge\diffmerge.exe') {
	includeEnvironmentPath('C:\Program Files (x86)\SourceGear\DiffMerge');
} else {
	$shorthandSoIdontHaveToLearnANewExeName = "C:\Program Files\SourceGear\Common\DiffMerge\diffmerge.exe"
	if (-not (test-path "C:\Program Files\SourceGear\Common\DiffMerge\diffmerge.exe")) {
		$original = "C:\Program Files\SourceGear\Common\DiffMerge\sgdm.exe"
		
		if (test-path $original) {
			if (-not (test-path $shorthandSoIdontHaveToLearnANewExeName)) {
				cp $original $shorthandSoIdontHaveToLearnANewExeName
			}
		}
	}
	includeEnvironmentPath("C:\Program Files\SourceGear\Common\DiffMerge");
}

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
set-alias msbuild "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe"

set-alias linq-where where-object

. DebuggingLibrary.ps1
. gitutils.ps1
. miscutils.ps1
. EncryptDecryptString.PS1

import-module WebAdministration
import-module c:\src\local-config\imports\LINQ.psm1

Import-Module DistributedCacheAdministration
if (get-module [D]istributedCacheAdministration) {
	Use-CacheCluster;
}

set-location c:\src


"  "
"Would you like to play a game of chess?  "
"  "
