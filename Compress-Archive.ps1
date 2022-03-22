$date = Get-Date -Format 'yyyy_MM_dd'
$source = 'c:\backup\source'
$destination = 'c:\backup\destination'

Compress-Archive -Path $source -DestinationPath $destination\$($date).zip
