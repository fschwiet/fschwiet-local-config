#
# Windows PowerShell in Action
#
# Chapter 9 Debugging tools
#
# This script defines two function that are useful
# for script debugging.
#

#
# This function will set a breakpoint in a script
# It optionally allows a condition scriptblock
# to be passed. If the scriptblock evaluates to true
# then the breakpoint will fire.
#
function global:bp ([scriptblock] $condition)
{
    if ($condition)
    {
        if (. $condition)
        {
            $host.UI.WriteLine("*break*")
            $host.EnterNestedPrompt()
        }
    } else {
        $host.UI.WriteLine("*break*")
        $host.EnterNestedPrompt()
    }
}

#
# This function will display the stack of calling functions
# on the console.
#
function global:gcs
{
    trap { continue }
    0..100 | % {
        (gv -scope $_ myinvocation).value.positionmessage -replace "`n"
    }
}

