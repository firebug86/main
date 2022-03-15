Import-Module ActiveDirectory
$Path = 'OU=test,OU=2020,OU=HQ,OU=Dismissed Users,DC=test,DC=ru' #Путь к уволенным сотрудникам
$Users = Get-ADUser -filter * -SearchBase $Path -Properties * | Select-Object *

ForEach ($User In $Users){

$DistinguishedName = $User.DistinguishedName      #Отличительное (уникальное) имя
$SamAccountName = $User.SamAccountName            #Имя входа пользователя (пред-Windows 2000)
$DisplayName = $User.DisplayName                  #Выводимое имя
$FullName = $User.Name                            #Полное имя
$Last = $User.Surname                             #Фамилия
$First = $User.GivenName                          #Имя
$NewName = "$Prefix$Last $First"                  #Новое имя полное
$Prefix = "DISM_"                                 #Префикс

Set-ADUser -Identity $DistinguishedName -Clear "extensionAttribute5"
Set-ADUser -Identity $DistinguishedName -Description $User.Title

    If ($DisplayName -notlike "$Prefix*") {Set-ADUser -Identity $DistinguishedName -Replace @{'DisplayName' = "$Prefix$DisplayName"} }
        If ($SamAccountName -notlike "$Prefix*") { Set-ADUser -Identity $SamAccountName -Replace @{'SamAccountName' = "$Prefix$SamAccountName"} }
            If ($FullName -notlike "$Prefix*") {Rename-ADObject -Identity $DistinguishedName -NewName $NewName}
                If ($User.extensionAttribute5 -match '\w') {Write-Host $User.DisplayName -ForegroundColor DarkRed -BackgroundColor Yellow}
                    Else {Write-Host $User.DisplayName -ForegroundColor Gray}
}
<### Отключение учетных записей в OU $Path ###>
Get-ADUser -Filter '*' -SearchBase $Path | Disable-ADAccount
<### Отключение учетных записей в OU $Path ###>
