Get-NetTCPConnection -State Established |
Select-Object -Property LocalAddress, LocalPort, 
						@{name='DNSName';expression={(Resolve-DnsName $_.RemoteAddress).NameHost}},
						RemoteAddress, RemotePort, State,
                        @{name='Process';expression={(Get-Process -Id $_.OwningProcess).Name}}, CreationTime |
Format-Table -AutoSize