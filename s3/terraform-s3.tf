provider "aws" {
  region = "{{ $sys.deploymentCell.region }}"
}

# Create an S3 bucket
resource "aws_s3_bucket" "repobucket" {
  bucket = "{{ $sys.id }}-harbor-bucket" # The name of the bucket
  acl    = "private"              # Access control list (e.g., private, public-read)

  # Enable versioning (optional)
  versioning {
    enabled = true
  }

  # Add tags to the bucket (optional)
  tags = {
    TenantID        = "{{ $sys.tenant.userID }}"
    TenantOrgID     = "{{ $sys.tenant.orgId }}"
    TenantOrgName  = "{{ $sys.tenant.orgName }}"
  }
}

# Output block to export the bucket ARN
output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.repobucket.arn
}

# Output block to export the bucket name
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.repobucket.bucket
}