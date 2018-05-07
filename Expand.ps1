<#
    Expand
    Written by Luke Brady, 2018
    University of North Georgia
#>

# Import the Expand module that will be used in the Expand executable.
Import-Module $PSScriptRoot\Expand
# Import vSphere PowerCLI for use within script.
if ( !(Get-Module -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue) ) {
    . "C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1"
}
<#
    Read-ExConfiguration reads in the Expand JSON config file
    and converts it into an object that can be used throughout
    the execution of the program.
#>
function Read-ExConfiguration {
    [CmdletBinding()]
    [OutputType([hashtable])]
    Param (
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )
    Process {
        # Read in the JSON configuration file supplied to the function.
        $confHash = Get-Content -Raw -Path $Path | ConvertFrom-Json | Convertto-ExHashTable
    }
    End {
        # Return the config hashtable.
        return $confHash
    }
}

$config = Read-ExConfiguration -Path $PSScriptRoot\Configuration\expand.config.json
$keys = $config.Keys
$confArr = @()
foreach($key in $keys) {
    $confArr += $config.$key
}

$confArr[1].Keys