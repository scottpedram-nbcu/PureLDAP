# $Creds = Get-Credential
$arrays = ("ussdipure01")
$LDAPServerAndPort = ("duoproxy.inbcu.com:2389")
function UpdateLDAPserver {
	param (
		$LDAPserver
	)
	Invoke-Pfa2CLICommand -EndPoint $array -Credential $Creds -CommandText "pureds setattr --uri ldaps://${LDAPserver}"
}

foreach ($array in $arrays) {
	Write-Host $array
	$CertValue = (Invoke-Pfa2CLICommand -EndPoint $array -Credential $Creds -CommandText "purecert list --csv")
	if ($CertValue -like '*NBCU*') {
		Write-Host "NBCU cert present, clear to proceed"
		UpdateLDAPserver $LDAPServerAndPort
	}
	else {
		Write-Host "No NBCU Certificate present!!!"
	}
}
