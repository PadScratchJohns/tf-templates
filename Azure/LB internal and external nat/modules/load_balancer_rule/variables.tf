variable "load_balancer_rule_name" {
  type        = string
  description = "Specifies the name of the LB Rule. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+$", var.load_balancer_rule_name))
    error_message = "The load_balancer_rule_name value must match the regex expression '[A-Za-z0-9-_]+$' (e.g. UKS_DB_HA1_LB-rule01)"
  }
}

variable "load_balancer_id" {
  type        = string
  description = "The ID of the Load Balancer in which to create the Rule. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Network/loadBalancers/[a-z0-9-_]+$", var.load_balancer_id))
    error_message = "The load_balancer_id value must be the Azure Resource UID format, (e.g. /subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Network/loadBalancers/ne-db-ha-lb)."
  }
}

variable "frontend_ip_configuration_name" {
  type        = string
  description = "Specifies the name of the LB Rule. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+$", var.frontend_ip_configuration_name))
    error_message = "The frontend_ip_configuration_name value must match the regex expression '[A-Za-z0-9-_]+$' (e.g. LoadBalancerFrontEnd)"
  }
}

variable "protocol" {
  type        = string
  description = "The transport protocol for the external endpoint. Possible values are Tcp, Udp or All."

  validation {
    condition     = contains(["Tcp", "Udp", "All"], var.protocol)
    error_message = "The protocol value must be one of: 'Tcp', 'Udp', 'All'."
  }
}

variable "frontend_port" {
  type        = number
  description = "The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive."

  validation {
    condition     = var.frontend_port >= 0 && var.frontend_port <= 65534
    error_message = "The frontend_port value must be between 0 and 65534."
  }
}

variable "backend_port" {
  type        = number
  description = "The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive."

  validation {
    condition     = var.backend_port >= 0 && var.backend_port <= 65535
    error_message = "The backend_port value must be between 0 and 65535."
  }
}

variable "backend_address_pool_ids" {
  type        = list(string)
  description = "A list of reference to a Backend Address Pool over which this Load Balancing Rule operates."
  default     = null

  # validation { # TODO
  # }
}

variable "probe_id" {
  type        = string
  description = "A reference to a Probe used by this Load Balancing Rule."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Network/loadBalancers/[a-z0-9-_]+/probes/[A-Za-z0-9-_]+$", var.probe_id))
    error_message = "The probe_id value must be the Azure Resource UID format, (e.g. /subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Network/loadBalancers/ne-db-ha-lb/probes/UKS_DB_HA_LoadBalancer_HealthProbe01)."
  }
}

variable "enable_floating_ip" {
  type        = bool
  description = "Are the Floating IPs enabled for this Load Balncer Rule? A \"floating\" IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false."
  default     = false
}

variable "idle_timeout_in_minutes" {
  type        = number
  description = "Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes."
  default     = 4

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 30
    error_message = "The idle_timeout_in_minutes value must be between 4 and 30."
  }
}

variable "load_distribution" {
  type        = string
  description = "Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively."
  default     = "Default"

  validation {
    condition     = contains(["Default", "SourceIP", "SourceIPProtocol", "None", "Client IP", "Client IP and Protocol"], var.load_distribution)
    error_message = "The load_distribution value must be one of: 'Default', 'SourceIP', 'SourceIPProtocol', 'None', 'Client IP', 'Client IP and Protocol'."
  }
}

variable "disable_outbound_snat" {
  type        = bool
  description = "Is snat enabled for this Load Balancer Rule? Default false."
  default     = false
}

variable "enable_tcp_reset" {
  type        = bool
  description = "Is TCP Reset enabled for this Load Balancer Rule?"
  default     = null
}