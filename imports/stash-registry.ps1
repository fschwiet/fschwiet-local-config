param($name) 

function makeAbsoluate($path) {
	join-path "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\" $path
}

$si_root = makeAbsoluate "SysInternals"
if (-not (test-path $si_root)) {
	new-item $si_root
}

$dbg_root = makeAbsoluate "SysInternals\DbgView"

if (-not (test-path $dbg_root)) {
	new-item $dbg_root
}

$dbgStash = gi $dbg_root

if (-not ($dbgStash | get-itemproperty).$name) {
	$newGuid = [Guid]::NewGuid().ToString()
	$dbgStash | set-itemproperty -name $name -value $newGuid
}

($dbgStash | get-itemproperty).$name
 