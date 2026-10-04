$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
  docker compose up -d db | Out-Host
  $ready=$false
  for($i=0;$i -lt 40;$i++){
    $status=docker inspect --format='{{.State.Health.Status}}' next-postgres-aws-production-demo-db-1 2>$null
    if($status -eq 'healthy'){ $ready=$true; break }
    Start-Sleep -Seconds 2
  }
  if(-not $ready){ throw 'Postgres did not become healthy' }
  $sql=@"
BEGIN;
SET LOCAL ROLE app_runtime;
SELECT set_config('app.tenant_id','11111111-1111-1111-1111-111111111111',true);
SELECT count(*) FROM records;
COMMIT;
BEGIN;
SET LOCAL ROLE app_runtime;
SELECT set_config('app.tenant_id','22222222-2222-2222-2222-222222222222',true);
SELECT count(*) FROM records;
COMMIT;
"@
  $out=$sql | docker exec -i next-postgres-aws-production-demo-db-1 psql -U adminuser -d appdb -At
  $nums=@($out | Where-Object { $_ -match '^\d+$' })
  if($nums.Count -lt 2 -or $nums[0] -ne '1' -or $nums[1] -ne '1'){ throw "RLS test failed: $($nums -join ',')" }
  Write-Host 'RLS_TEST_PASS'
} finally { Pop-Location }
