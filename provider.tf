terraform {
  required_version = ">= 0.12"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.36.0"
    }
  }
}

provider "ibm" {
  region = "us-south"
}
