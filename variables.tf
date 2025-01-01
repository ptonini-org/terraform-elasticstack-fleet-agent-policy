variable "name" {}

variable "namespace" {
  default  = "default"
  nullable = false
}

variable "description" {
  default = null
}

variable "policy_id" {
  default = null
}

variable "fleet_server_host_id" {
  default = null
}

variable "monitoring_output_id" {
  default = null
}

variable "data_output_id" {
  default = null
}

variable "sys_monitoring" {
  default  = true
  nullable = false
}

variable "monitor_logs" {
  default  = true
  nullable = false
}

variable "monitor_metrics" {
  default  = true
  nullable = false
}

variable "integration_policies" {
  type = map(object({
    name                = optional(string)
    description         = optional(string)
    integration_name    = optional(string)
    integration_version = optional(string)
    inputs = optional(map(object({
      input_id     = optional(string)
      enabled      = optional(bool)
      streams_json = optional(string)
      vars_json    = optional(string)
    })), {})
  }))
  default = {}
}