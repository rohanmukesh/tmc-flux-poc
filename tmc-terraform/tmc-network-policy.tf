resource "tanzu-mission-control_network_policy" "workspace_scoped_allow-all_network_policy" {
  name = "tf-network-policy"

  scope {
    workspace {
      workspace = "rohan-workspace-for-explore"
    }
  }

  spec {
    input {
      allow_all {
        from_own_namespace = true
      }
    }

    namespace_selector {
      match_expressions {
        key      = "component"
        operator = "In"
        values = [
          "api-server",
          "agent-gateway"
        ]
      }
      match_expressions {
        key      = "not-a-component"
        operator = "DoesNotExist"
        values   = []
      }
    }
  }
}
