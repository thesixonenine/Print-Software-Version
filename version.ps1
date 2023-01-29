Param(
    [Parameter(Mandatory=$false,
    ValueFromPipeline=$true)]
    [string]
    $spec_command
)
$spec_command_exist = ![string]::IsNullOrEmpty($spec_command)
$spec_command_found = False
foreach($line in [System.IO.File]::ReadLines("software")){
    if ([string]::IsNullOrEmpty($line)) {
        continue
    }
    
    $Arr = $line.Split(",")
    $SoftwareName = $Arr[0]
    $Command = $Arr[1]
    $CommandVersion = "& " + $Arr[2]

    if ($spec_command_exist) {
        $spec_command_found = ${Command} -match ${spec_command}
        if (!$spec_command_found){
            continue
        }
    }

    which $Command > $null 2>&1
    if ($?) {
        Invoke-Expression $CommandVersion
    } else {
        "${Command} command not exist."
    }
    ""

    if ($spec_command_exist && $spec_command_found) {
        break
    }
}