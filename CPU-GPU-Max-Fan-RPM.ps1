param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

function Show-Menu
{
    param (
        [string]$Title = 'CPU & GPU Max Fan RPM'
    )
    Clear-Host
    Write-Host "1: Press '1' to CPU & GPU Max Fan RPM."
    Write-Host "Q: Press 'Q' to quit."
}

function MAX
{

(Get-WmiObject -Namespace Root/WMI -Class AsusAtkWmi_WMNB).DEVS(0x00110022,255) | Out-Null
(Get-WmiObject -Namespace Root/WMI -Class AsusAtkWmi_WMNB).DEVS(0x00110023,255) | Out-Null

}

do
{
    Show-Menu –Title 'CPU & GPU Max Fan RPM'
    $input = Read-Host "What do you want to do?"
    switch ($input)
    {
        '1' {               
                MAX
            }

        'q' {
                 return
            }
    }

}
until ($input -eq 'q')