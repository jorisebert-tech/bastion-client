# Set the directory containing the runtime files
$clientDir   = Join-Path $PSScriptRoot "client"
$runtimesDir = Join-Path $PSScriptRoot "runtimes"

# -----------------------------
# Client checksum (single file)
# -----------------------------
$clientFile = Join-Path $clientDir "client.jar"

$clientHash = Get-FileHash -Path $clientFile -Algorithm SHA256

$clientResult = [PSCustomObject]@{
    file     = "client.jar"
    checksum = $clientHash.Hash
}

$clientJson = $clientResult | ConvertTo-Json -Depth 3
$clientOutput = Join-Path $clientDir "client_version.json"
$clientJson | Out-File -FilePath $clientOutput -Encoding UTF8

Write-Host "Client checksum saved to $clientOutput"

# -----------------------------
# Runtimes checksums (all files)
# -----------------------------
$files = Get-ChildItem -Path $runtimesDir -File
$result = @()

foreach ($file in $files) {
    $hash = Get-FileHash -Path $file.FullName -Algorithm SHA256

    $result += [PSCustomObject]@{
        file     = $file.Name
        checksum = $hash.Hash
    }
}

$runtimesJson = $result | ConvertTo-Json -Depth 3
$runtimesOutput = Join-Path $runtimesDir "runtime_versions.json"
$runtimesJson | Out-File -FilePath $runtimesOutput -Encoding UTF8

Write-Host "Runtime checksums saved to $runtimesOutput"
