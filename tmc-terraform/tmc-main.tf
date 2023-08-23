# Provider configuration for TMC SaaS

terraform {
  required_providers {
    tanzu-mission-control = {
      source = "vmware/tanzu-mission-control"
      version = "1.2.1"    # it's the provider version and you can change it as version changes
    }
  }
}

variable "endpoint" {
  type        = string
  description = "TMC endpoint"
}
variable "vmw_cloud_api_token" {
  type        = string
  description = "TMC API Token"
}

provider "tanzu-mission-control" {
  endpoint            = var.endpoint            # optionally use TMC_ENDPOINT env var
  vmw_cloud_api_token = var.vmw_cloud_api_token # optionally use VMW_CLOUD_API_TOKEN env var

  # if you are using dev or different csp endpoint, change the default value below
  # for production environments the vmw_cloud_endpoint is console.cloud.vmware.com
  # vmw_cloud_endpoint = "console.cloud.vmware.com" or optionally use VMW_CLOUD_ENDPOINT env var
}

resource "tanzu-mission-control_cluster_group" "create_cluster_group_min_info" {
  name = "rohan-cluster-group-using-tf-for-explore"
  meta {
    description = "cluster group created through terraform"
    labels = {
      "createdby" : "rohan",
      "usedfor" : "vmware-explore"
    }
  }
}

resource "tanzu-mission-control_custom_policy" "cluster_group_scoped_tmc-audit_custom_policy" {
  name = "tf-custom-test"

  scope {
    cluster_group {
      cluster_group = "rohan-cluster-group-using-tf-for-explore"
    }
  }
  spec {
    input {
      strict {
        audit              = true
        disable_native_psp = true
      }
    }
    namespace_selector {
      match_expressions {
        key      = "component"
        operator = "DoesNotExist"
        values   = []
      }
    }
  }
 }

