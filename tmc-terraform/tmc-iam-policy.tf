
resource "tanzu-mission-control_iam_policy" "cluster_group_scoped_iam_policy" {
  scope {
    cluster_group {
      name = "rohan-cluster-group-using-tf-for-explore"
    }
  }

  role_bindings {
    role = "clustergroup.admin"
    subjects {
      name = "nick"
      kind = "USER"
    }
  } 
}

resource "tanzu-mission-control_iam_policy" "workspace_scoped_iam_policy" {
  scope {
    workspace {
      name = "rohan-workspace-for-explore"
    }
  }

  role_bindings {
    role = "workspace.edit"
    subjects {
      name = "romukesh"
      kind = "USER"
    }
  }
}
