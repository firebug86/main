$path = 'C:\test_dir'
$date = Get-Date -Format yyyy-MM-dd
New-Item -ItemType Directory -Path $path -Name $date
