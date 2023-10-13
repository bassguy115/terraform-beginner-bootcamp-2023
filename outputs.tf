output "bucket_name" {
    description = "Bucket name fore our static website"
    value = module.home_redandblack_hosting.bucket_name
}

output "s3_website_endpoint" {
    description = "S3 Static Website hosting endpoint"
    value = module.home_redandblack_hosting.website_endpoint
}

output "cloufront_url" {
    description = "The CloudFront Distribution Domain Name"
  value = module.home_redandblack_hosting.domain_name  
}