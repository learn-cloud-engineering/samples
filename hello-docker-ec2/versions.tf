# Version symbols:
# ~> 5.0 : Best practice. Allows any 5.x version, but not 4.x or 6.x.
# >= 5.0.0 : Loose. Must at least be this version or higher.
# = X.Y.Z   : Strict. Allows only this exact version.

terraform {
  required_version = ">= 1.14.0" # Allows any version 1.14.0 or higher
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Allows any 6.x version, but not 5.x or 7.x
    }
  }
}
