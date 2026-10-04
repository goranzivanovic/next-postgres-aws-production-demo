# Backup and restore proof

Local backup:
docker exec next-postgres-aws-production-demo-db-1 pg_dump -U appuser -d appdb -Fc -f /tmp/appdb.dump

Restore drill:
1. Copy the dump from the container.
2. Create a clean verification database.
3. Restore with pg_restore.
4. Verify record counts and tenant-isolation tests.

For RDS, use automated snapshots plus a scheduled restore drill. Backup is not considered proven until restore is tested.
