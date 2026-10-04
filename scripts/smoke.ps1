$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
Push-Location $root
$proc=$null
try {
  $env:DATABASE_URL='postgresql://adminuser:adminpass@localhost:54329/appdb'
  docker compose up -d db | Out-Host
  $proc=Start-Process -FilePath 'npm.cmd' -ArgumentList @('start','--','-p','3100') -PassThru -WindowStyle Hidden
  Start-Sleep -Seconds 4
  $resp=Invoke-WebRequest -UseBasicParsing -Uri 'http://127.0.0.1:3100/'
  if($resp.Content -notmatch 'Production-Ready Next.js'){ throw 'Home smoke failed' }
  $health=Invoke-RestMethod -Uri 'http://127.0.0.1:3100/api/health'
  if(-not $health.ok){ throw 'Health endpoint failed' }
  Write-Host 'SMOKE_PASS'
} finally {
  if($proc -and -not $proc.HasExited){ Stop-Process -Id $proc.Id -Force }
  Pop-Location
}
