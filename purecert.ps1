# $Creds = Get-Credential
$arrays = ("uspotpure01", "usbncpure03")
foreach ($array in $arrays) {
	Write-Host $array
	$CertValue = (Invoke-Pfa2CLICommand -EndPoint $array -Credential $Creds -CommandText "purecert list --csv")
	if ($CertValue -like '*NBCU*') {
		Write-Host "NBCU cert present, no action required"
	}
	else {
		Write-Host "No NBCU Certificate present!!!"
	}
}
