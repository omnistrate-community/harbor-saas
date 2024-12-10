terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.13"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
  description = "The API token for Cloudflare"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "The Account ID for Cloudflare"
  type        = string
}

variable "cloudflare_bucket_location" {
  description = "The location for the R2 Bucket"
  type        = string
}

variable "cloudflare_bucket_name" {
  description = "The name for the R2 Bucket"
  type        = string
}

resource "cloudflare_r2_bucket" "my_bucket" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_bucket_name
  location   = var.cloudflare_bucket_location
}

output "r2_bucket_endpoint" {
  description = "The S3 API endpoint URL for the Cloudflare R2 bucket"
  value       = "${var.cloudflare_account_id}.r2.cloudflarestorage.com"
}
