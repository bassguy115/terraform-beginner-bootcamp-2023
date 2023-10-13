## Terrahome AWS

The following directory

```
module "home_redandblack" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.redandblack-colors_public_path
  content_version = var.content_version  
} 
```

The public directory expects the following:
- index.html
- error.html
- assests

all top level files in assets will be copied, but not any subdirectories