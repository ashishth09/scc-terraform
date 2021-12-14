resource "ibm_scc_si_occurrence" "occurrence" {
  provider_id   = var.provider_id
  note_name     = "${var.account_id}/providers/${var.provider_id}/notes/${ibm_scc_si_note.active_freeze_window.note_id}"
  kind          = "FINDING"
  occurrence_id = "finding-occ"
  resource_url  = "https://cloud.ibm.com"
  remediation   = "Limit the cluster access"
  context {
    resource_name = "mycluster"
    resource_type = "cluster"
  }
  finding {
    severity  = "HIGH"
    certainty = "LOW"
    next_steps {
      title = "Active freeze window"
      url   = "https://cloud.ibm.com/security-compliance/findings"
    }
  }
}




