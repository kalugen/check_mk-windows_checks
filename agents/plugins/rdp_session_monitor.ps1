function Get-TSSessions {
    param(
        $ComputerName = "localhost"
    )

    $header = "Sesion","User","State"

    qwinsta /server:$ComputerName |
    findstr 'rdp-tcp#' |
    ForEach-Object {
        $_.Trim() -replace "\s+",","
    } |
    ConvertFrom-Csv -Header $header
}

Write-Output "<<<windows_rdp_sessions>>>"

Get-TSSessions | Format-Table -HideTableHeaders

