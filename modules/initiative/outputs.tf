output "id" {
  description = "The Id of the Policy Set Definition"
  value       = local.initiative_id
}

output "name" {
  description = "The name of the Policy Set Definition"
  value       = var.initiative_name
}

output "parameters" {
  description = "The combined parameters of the Policy Set Definition"
  value       = local.parameters
}

output "metadata" {
  description = "The metadata of the Policy Set Definition"
  value       = local.metadata
}

output "role_definition_ids" {
  description = "Role definition IDs for remediation"
  value       = local.all_role_definition_ids
}

output "non_compliance_messages" {
  description = "Generated Key/Value map of non-compliance messages"
  value       = local.non_compliance_messages
}

output "initiative" {
  description = "The combined Policy Initiative resource node"
  value = {
    id                  = local.initiative_id
    name                = var.initiative_name
    display_name        = var.initiative_display_name
    description         = var.initiative_description
    management_group_id = var.management_group_id
    parameters          = local.parameters
    metadata            = jsonencode(local.metadata)
    reference_ids       = flatten([for i in local.policy_definition_reference : values({ reference_id = i.reference_id })])
    role_definition_ids = local.all_role_definition_ids
    replace_trigger     = local.replace_trigger

    policy_definition_reference = [
      for i in local.policy_definition_reference : {
        parameter_values     = i.parameter_values
        policy_definition_id = i.policy_definition_id
        reference_id         = i.reference_id
      }
    ]
  }
}
