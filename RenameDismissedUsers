import-module activedirectory
$Path = 'OU=test,OU=2020,OU=HQ,OU=Dismissed Users,DC=test,DC=ru'
$users = Get-ADUser -filter 'SamAccountName -Notlike "DISM_*"' -SearchBase $Path -Properties DisplayName | Select DisplayName, GivenName, Surname, Name, DistinguishedName
ForEach ($User In $Users)
{
    $DN = $User.DistinguishedName
    $First = $User.GivenName
    $Last = $User.Surname
    $CN = $User.Name
    $Display = $User.DisplayName
    $NewName = "DISM_$First $Last"
    If ($Display -ne $NewName) {Set-ADUser -Identity $DN -DisplayName $NewName}
    If ($CN -ne $NewName) {Rename-ADObject -Identity $DN -NewName $NewName}
}
