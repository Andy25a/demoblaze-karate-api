[CmdletBinding()]
param(
    [switch]$SkipOpenReport
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$logDir = Join-Path $projectRoot "reports\execution-logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$logFile = Join-Path $logDir "run-$timestamp.log"

function Write-Section {
    param([string]$Message)
    Write-Host ""
    Write-Host "==== $Message ====" -ForegroundColor Cyan
}

Write-Section "Validaciones previas"
if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    throw "No se encontró Java en PATH."
}
if (-not (Test-Path (Join-Path $projectRoot "mvnw.cmd"))) {
    throw "No se encontró mvnw.cmd en la raíz del proyecto."
}

Write-Section "Ejecución de pruebas Karate"
$mavenArgs = "clean test -Dtest=DemoblazeApiKarateSuite"
Write-Host "Comando: .\mvnw.cmd $mavenArgs"
cmd /c "cd /d `"$projectRoot`" && mvnw.cmd $mavenArgs 2>&1" | Tee-Object -FilePath $logFile
if ($LASTEXITCODE -ne 0) {
    throw "La ejecución falló. Revisa el log: $logFile"
}

Write-Section "Exportación de reportes"
$source = Join-Path $projectRoot "target\karate-reports"
$dest = Join-Path $projectRoot "reports\karate"
if (-not (Test-Path $source)) {
    throw "No existe '$source'. No se encontró reporte de Karate."
}
if (Test-Path $dest) {
    Remove-Item -Recurse -Force -Path $dest
}
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Recurse -Force -Path (Join-Path $source "*") -Destination $dest

$summary = Join-Path $dest "karate-summary.html"
Write-Section "Resultado"
Write-Host "Ejecución completada correctamente." -ForegroundColor Green
Write-Host "Reporte Karate : $summary"
Write-Host "Log de ejecución: $logFile"

if (-not $SkipOpenReport -and (Test-Path $summary)) {
    Write-Section "Abriendo reporte"
    Start-Process $summary
}
