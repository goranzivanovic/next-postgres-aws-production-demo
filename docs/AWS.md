# AWS deployment blueprint

This public demo does not claim to be running in a paid AWS account.

It includes a deployment blueprint for:
- Amazon RDS PostgreSQL in private subnets
- Secrets Manager / AWS-managed database credentials
- encrypted storage and retained backups
- PostgreSQL logs exported to CloudWatch
- least-privilege runtime IAM permissions

Production steps: create a VPC with two private subnets, replace placeholder subnet IDs, deploy the RDS stack, grant only required secret/log permissions, add CloudWatch alarms, and run a restore drill before go-live.

No AWS credentials, real account IDs, subnet IDs, or private endpoints belong in this repository.
