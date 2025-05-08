variable "load_balancer_probe_name" {
  type        = string
  description = "Specifies the name of the Probe. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+$", var.load_balancer_probe_name))
    error_message = "The load_balancer_probe_name value must match the regex expression '[A-Za-z0-9-_]+$' (e.g. UKS_DB_HA_LoadBalancer_HealthProbe_Tcp)"
  }
}

variable "load_balancer_id" {
  type        = string
  description = "The ID of the LoadBalancer in which to create the NAT Rule. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Network/loadBalancers/[a-z0-9-_]+$", var.load_balancer_id))
    error_message = "The load_balancer_id value must be the Azure Resource UID format, (e.g. /subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Network/loadBalancers/ne-db-ha-lb)."
  }
}

variable "protocol" {
  type        = string
  description = "Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful."

  validation {
    condition     = contains(["Http", "Https", "Tcp"], var.protocol)
    error_message = "The protocol value must be one of: 'Http', 'Https', 'Tcp'."
  }
}

variable "port" {
  type        = number
  description = "Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive."

  validation {
    condition     = var.port >= 1 && var.port <= 65535
    error_message = "The port value must be between 1 and 65535."
  }
}

variable "probe_threshold" {
  type        = number
  description = "The number of consecutive successful or failed probes that allow or deny traffic to this endpoint. Possible values range from 1 to 100. The default value is 1."
  default     = 1

  validation {
    condition     = var.probe_threshold >= 1 && var.probe_threshold <= 100
    error_message = "The probe_threshold value must be between 1 and 100."
  }
}

variable "request_path" {
  type        = string
  description = "The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed."
  default     = null

  # validation { # TODO
  # }
}

variable "interval_in_seconds" {
  type        = number
  description = "The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5."
  default     = 15

  validation {
    condition     = var.interval_in_seconds >= 5 && var.interval_in_seconds <= 300
    error_message = "The interval_in_seconds value must be between 5 and 300."
  }
}

variable "number_of_probes" {
  type        = number
  description = "The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful."
  default     = 2

  # validation { # TODO
  # }
}