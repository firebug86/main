$DCc = Get-ADDomainController -Filter * | Select-Object Hostname,Ipv4address,isGlobalCatalog,Site,Forest,OperatingSystem

ForEach($DC in $DCc)
{
    $PortResult=Test-NetConnection -ComputerName $DC.Hostname -Port 636 -InformationLevel Quiet
    if ($PortResult -ne "$True"){
        write-host $DC.Hostname " не доступен" -BackgroundColor Red -ForegroundColor White
    }else {
    write-host $DC.Hostname " доступен" -BackgroundColor Green -ForegroundColor White}
}
