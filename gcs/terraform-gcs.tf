# Google provider configuration
provider "google" {
  project     = "{{ $sys.deployment.cloudProviderAccountID }}"
  region      = "{{ $sys.deploymentCell.region }}"
}

# Create a GCS bucket
resource "google_storage_bucket" "repobucket" {
  name          = "{{ $sys.id }}-harbor-bucket"
  location      = "US"                     # Bucket location
  storage_class = "STANDARD"               # Storage class (e.g., STANDARD, NEARLINE, COLDLINE, ARCHIVE)

  # Enable versioning (optional)
  versioning {
    enabled = true
  }

  # Add labels (optional)
  labels = {
    TenantID        = "$sys.tenant.userID"
    TenantOrgID     = "$sys.tenant.orgID"
    TenantOrgName  = "$sys.tenant.orgName"
  }
}

# Output block to export the bucket's ARN
output "bucket_arn" {
  description = "The ARN of the GCS bucket"
  value       = google_storage_bucket.repobucket.url
}

# Output block to export the bucket name
output "bucket_name" {
  description = "The name of the GCS bucket"
  value       = google_storage_bucket.repobucket.name
}