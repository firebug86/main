$MoveComputer = 'ComputerName'                                                  #Имя компьютера
$OUPath = 'OU=Computers,OU=HQ,OU=BRANCHES,DC=contoso,DC=com'                    #Пусь к целевому контейнеру 
Get-ADComputer -Identity $MoveComputer | Move-ADObject -TargetPath $OUPath      
Get-ADComputer -SearchBase $OUPath -Filter * | ForEach-Object -Process {
    if ($_.Name -ne $MoveComputer){Write-Host $_.Name -ForegroundColor Gray}    #Если имя ПК не совподает то закрашиваем серым
    else{Write-Host $_.Name 'Перемещен' -ForegroundColor Green}                 #Если совподает зеленым
    }
