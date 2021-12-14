resource "ibm_scc_si_note" "active_freeze_window" {
  provider_id       = var.provider_id
  short_description = "Change requested in an active freeze window"
  long_description  = "A change in one of your resources was pushed with a active Freeze Window. Or, freeze window verification failed."
  kind              = "FINDING"
  note_id           = "policy-gate-freeze-active"
  reported_by {
    id    = "Kubernetes admission controller"
    title = "Kubernetes admission controller"
    url   = "https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/"
  }
  finding {
    severity = "CRITICAL"
    next_steps {
      title = "A change can only be made once the freeze is lifted."
      url   = "http://example.com"
    }
  }
}

resource "ibm_scc_si_note" "invalid_change_request" {
  provider_id       = var.provider_id
  short_description = "Change requested with a closed Change Request ID"
  long_description  = "A change in one of your resources was pushed with a Change Request ID that is already closed. Or, Change Request validation failed."
  kind              = "FINDING"
  note_id           = "policy-gate-cr-closed"
  reported_by {
    id    = "Kubernetes admission controller"
    title = "Kubernetes admission controller"
    url   = "https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/"
  }
  finding {
    severity = "LOW"
    next_steps {
      title = "Verify why this change was requested."
      url   = "http://example.com1"
    }
    next_steps {
      title = "If the requested change is reasonable, create a valid Change Request and add its ID as a 'label' in the 'spec.template.metadata.labels.changeID' section of your resource."
      url   = "http://example.com"
    }
  }
}

resource "ibm_scc_si_note" "card" {
  provider_id       = var.provider_id
  short_description = "Kubernetes admission controller Policy Enforcements"
  long_description  = "Kubernetes admission controller Policy Enforcements"
  kind              = "CARD"
  note_id           = "policy-gate-card"
  reported_by {
    id    = "Kubernetes admission controller"
    title = "Kubernetes admission controller"
    url   = "http://cloud.ibm.com"
  }
  card {
    section            = "Terraform Insights"
    title              = "Policy gate enforcements"
    subtitle           = "Admission controller2"
    finding_note_names = ["providers/scc/notes/policy-gate-freeze-active", "providers/scc/notes/policy-gate-cr-closed"]
    elements {
      kind               = "NUMERIC"
      default_time_range = "1d"
      text               = "Change requested in an active freeze window"
      value_type {
        finding_note_names = ["providers/scc/notes/policy-gate-freeze-active"]
        kind               = "FINDING_COUNT"
      }
    }
    elements {
      kind               = "NUMERIC"
      default_time_range = "2d"
      text               = "Change requested with a closed Change Request ID"
      value_type {
        finding_note_names = ["providers/scc/notes/policy-gate-cr-closed"]
        kind               = "FINDING_COUNT"
      }
    }

    elements {
      kind               = "TIME_SERIES"
      default_interval   = "1d"
      default_time_range = "4d"
      text               = "Changes requested with invalid configuration in past 7 days"
      value_types {
        finding_note_names = ["providers/scc/notes/policy-gate-freeze-active"]
        kind               = "FINDING_COUNT"
        text               = "Active freeze window"
      }
      value_types {
        finding_note_names = ["providers/scc/notes/policy-gate-cr-closed"]
        kind               = "FINDING_COUNT"
        text               = "Closed change request"
      }
    }
  }
}
