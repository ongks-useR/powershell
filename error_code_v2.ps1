# please change file path accordingly
$detail = Get-ChildItem -Path "C:\Users\v-kamong\Documents\ToSync\OneDrive - Microsoft\ANZ Bank\Non Delivery Report_NDR\EXO\Detail"

$data = $detail | ForEach-Object { Import-Csv -Path $_.FullName }
$unique = $data | Sort-Object -Property MessageTraceId -Unique

$unique = $unique | Select-Object -Property MessageTraceId, Detail, @{Name = "ErrorCode"; Expression = { 
    $_.Detail | Select-String -Pattern "\[(.+)\]" -AllMatches |
        ForEach-Object { $_.Matches.Groups[1].Value } |
        Select-String -Pattern '\{(.+)[\}\[]' -AllMatches |
        ForEach-Object { $_.Matches.Groups[1].Value }
}}

$unique = $unique | Select-Object -Property MessageTraceId, Detail, @{Name = 'ErrorCode'; Expression = {

    $dash = $_.Detail | Select-String -Pattern 'LED=\d+-\d+\.\d+\.\d+' -AllMatches
    $hash = $_.Detail | Select-String -Pattern 'LED=\d+[\s]#\d+\.\d+\.\d+' -AllMatches

    if ($dash) {
        $_.Detail -replace '-', ' '
    }
    elseif ($hash) {
        $_.Detail -replace '#', ''
    }
    else {
        $_.Detail
    }
}}

$unique | Select-Object -Property MessageTraceId, Detail, @{Name = 'ErrorCode'; Expression = {
    $_.ErrorCode | Select-String -Pattern 'LED=\d+\s(\d+\.\d+\.\d+)' -AllMatches |
    ForEach-Object { $_.Matches.Groups[1].Value }
}} |
Export-Csv -Path .\Desktop\ANZ_EXO_Detail_3.csv