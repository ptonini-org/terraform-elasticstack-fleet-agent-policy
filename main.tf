resource "elasticstack_fleet_agent_policy" "this" {
  name                 = var.name
  namespace            = var.namespace
  description          = var.description
  sys_monitoring       = var.sys_monitoring
  monitor_logs         = var.monitor_logs
  monitor_metrics      = var.monitor_metrics
  policy_id            = var.policy_id
  fleet_server_host_id = var.fleet_server_host_id
  monitoring_output_id = var.monitoring_output_id
  data_output_id       = var.data_output_id
}

resource "elasticstack_fleet_integration_policy" "this" {
  for_each            = var.integration_policies
  name                = coalesce(each.value.name, "${coalesce(each.value.integration_name, each.key)}-${var.name}")
  agent_policy_id     = elasticstack_fleet_agent_policy.this.id
  namespace           = elasticstack_fleet_agent_policy.this.namespace
  description         = each.value.description
  integration_name    = coalesce(each.value.integration_name, each.key)
  integration_version = each.value.integration_version

  dynamic "input" {
    for_each = each.value.inputs
    content {
      input_id     = coalesce(input.value.input_id, input.key)
      enabled      = input.value.enabled
      streams_json = input.value.streams_json
      vars_json    = input.value.vars_json
    }
  }
}

