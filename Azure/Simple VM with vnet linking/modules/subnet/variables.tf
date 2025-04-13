variable "subnet_name" {
  type        = string
  description = "The name of the subnet. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^[\\S]+$", var.subnet_name))
    error_message = "The subnet_name value must be a mix of alphanumeric characters."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-_]+_rg$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[a-z0-9-_]+_rg$' (e.g. cringey-customer-name_rg)"
  }
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("^[\\S]+$", var.virtual_network_name))
    error_message = "The virtual_network_name value must be a mix of alphanumeric characters."
  }
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet. Currently only a single address prefix can be set as the Multiple Subnet Address Prefixes Feature is not yet in public preview or general availability."

  validation {
    condition = length([
      for address in var.address_prefixes : true
      if can(regex("([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})/[1-32]", address))
    ]) == length(var.address_prefixes)
    error_message = "Each IP Address in the address_prefixes value must be in the CIDR format e.g. (8.8.8.8/32)."
  }
}

variable "delegation" {
  type = object({
    name = optional(string)
    service_delegation = optional(object({
      name    = optional(string)
      actions = optional(list(string))
    }))
    }
  )
  description = "One or more delegation blocks as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  description = "Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true."
  default     = true
}

variable "private_link_service_network_policies_enabled" {
  type        = bool
  description = "Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true."
  default     = true
}

variable "service_endpoints" {
  type        = list(string)
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web."
  default     = []

  validation {
    condition = length([
      for service_endpoint in var.service_endpoints : true
      if can(regex("(Microsoft\\.AzureActiveDirectory|Microsoft\\.AzureCosmosDB|Microsoft\\.ContainerRegistry|Microsoft\\.EventHub|Microsoft\\.KeyVault|Microsoft\\.ServiceBus|Microsoft\\.Sql|Microsoft\\.Storage|Microsoft\\.Storage\\.Global|Microsoft\\.Web)", service_endpoint))
    ]) == length(var.service_endpoints)
    error_message = "Each service endpoint in the variable service_endpoints value must be in the resource type format (e.g. 'Microsoft.AzureCosmosDb')."
  }
}

variable "service_endpoint_policy_ids" {
  type        = list(string)
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web."
  default     = null # for some reason this tries to send an empty list and is rejected if set to []

  validation {
    condition = try(length([
      for service_endpoint_policy_id in var.service_endpoint_policy_ids : true
      if can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[\\S]+/providers/Microsoft.Network/serviceEndpointPolicies/[\\S]+", service_endpoint_policy_id))
    ]) == length(var.service_endpoint_policy_ids) || var.service_endpoint_policy_ids == null, true)
    error_message = "Each service endpoint policy ID in the variable service_endpoint_policy_ids value must be in the resource UID format (e.g. '/subscriptions/your-sub-id-here/resourceGroups/rg1/providers/Microsoft.Network/serviceEndpointPolicies/testServiceEndpointPolicy')."
  }
}