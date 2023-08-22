resource "tanzu-mission-control_workspace" "create_workspace" {
  name = "rohan-workspace-for-explore"

  meta {
    description = "Create workspace through terraform"
    labels = {
      "cloud" : "vmware"
    }
  }
}

