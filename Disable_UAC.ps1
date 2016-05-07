#  This script will check to see if UAC is enabled and disable it if it is.  
#  This script will cause a reboot.

$UAC = Get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA

if ($UAC.EnableLUA -eq 1)
{
	Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -Value 0
	Restart-Computer	
}

else
{
	Write-Host "HKLM\Software\Microsoft\Windows\CurrentVersion\policies\system\EnableLUA already has a value of" $UAC.EnableLUA "so it will not be updated."
}