# I campi dell'output sono separati dal carattere ":"
Write-Output "<<<windows_print_queues:sep(58)>>>"

# Ottiene le liste via WMI
$jobs     = Get-WmiObject "Win32_PrintJob"
$printers = Get-WmiObject "Win32_Printer"

# Per ogni stampante, scriviamo nome e stato
$printers | foreach {
    Write-Output "QUEUE:$($_.Name):$($_.Status)"
}

# Per ogni job stampiamo nome stampante, stato job, owner, pagine del job
$jobs | foreach {
    $queueName = $_.Description.Split(',')[0]

    if($_.JobStatus) {
        $jobStatus = $_.JobStatus
    } else {
        $jobstatus = "UNKNOWN"
    }

    Write-Output "JOB:$($queueName):$($jobStatus):$($_.Owner):$($_.TotalPages)"
}