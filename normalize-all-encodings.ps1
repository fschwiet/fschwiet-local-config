foreach ($file in (& { gci . * -rec } | ? { -not $_.PSIsContainer })) { (get-content $file.fullname) | set-content $file.fullname -enc utf8 }
