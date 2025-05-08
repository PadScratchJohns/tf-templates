variable "storage_account_name" {
  description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-_]+$", var.storage_account_name))
    error_message = "The storage_account_name value must match the regex expression '[a-z0-9-_]+$' (e.g. dkccmaxstore)"
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string

}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to Storage."
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "The account_kind value must be one of: 'BlobStorage', 'BlockBlobStorage', 'FileStorage', 'Storage', 'StorageV2'."
  }
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account_tier value must be one of: 'Standard', 'Premium'."
  }
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "The account_replication_type value must be one of: 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', 'RAGZRS'."
  }
}

variable "cross_tenant_replication_enabled" {
  description = "Should cross Tenant replication be enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "The access_tier value must be one of: 'Hot', 'Cool'."
  }
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}

variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled, see https://docs.microsoft.com/en-us/azure/storage/storage-require-secure-transfer/ for more information."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  type        = string
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "The min_tls_version value must be one of: 'TLS1_0', 'TLS1_1', 'TLS1_2'."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled? Defaults to true."
  default     = true
}

variable "default_to_oauth_authentication" {
  type        = bool
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false."
  default     = false
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/ for more information). Changing this forces a new resource to be created."
  type        = bool
  default     = null
}

variable "nfsv3_enabled" {
  type        = bool
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false"
  default     = false
}

variable "custom_domain" {
  type = object({
    name          = optional(string)
    use_subdomain = optional(bool)
  })
  description = "A custom_domain block as defined above."
  default     = {}

  validation {
    condition     = ((can(regex("\"name\":\"[\\S]+\"", jsonencode(var.custom_domain))) || can(regex("\"name\":null", jsonencode(var.custom_domain)))) && (can(regex("\"use_subdomain\":(true|false)", jsonencode(var.custom_domain))) || can(regex("\"use_subdomain\":null", jsonencode(var.custom_domain))))) || length(var.custom_domain) == 0
    error_message = "One of the custom_domain properties does not match the expected syntax. Please review variables.tf regex."
  }
}

variable "identity" {
  type = object({
    type         = optional(string)
    identity_ids = optional(list(string))
  })
  description = "An identity block as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "blob_properties" {
  type = object({
    cors_rule = optional(object({
      allowed_headers    = optional(list(string))
      allowed_methods    = optional(list(string))
      allowed_origins    = optional(list(string))
      exposed_headers    = optional(list(string))
      max_age_in_seconds = optional(number)
    }))
    delete_retention_policy = optional(object({
      days = optional(number)
    }))
    versioning_enabled            = optional(bool)
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)
    container_delete_retention_policy = optional(object({
      days = optional(number)
    }))
  })
  description = "A blob_properties block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "queue_properties" {
  type = object({
    cors_rule = optional(object({
      allowed_headers    = optional(list(string))
      allowed_methods    = optional(list(string))
      allowed_origins    = optional(list(string))
      exposed_headers    = optional(list(string))
      max_age_in_seconds = optional(number)
    }))
    logging = optional(object({
      delete                = optional(bool)
      read                  = optional(bool)
      version               = optional(string)
      write                 = optional(bool)
      retention_policy_days = optional(number)
    }))
    minute_metrics = optional(object({
      enabled               = optional(bool)
      version               = optional(string)
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
    }))
    hour_metrics = optional(object({
      enabled               = optional(bool)
      version               = optional(string)
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
    }))
  })
  description = "A queue_properties block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "static_website" {
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  description = "A static_website block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "customer_managed_key" {
  type = object({
    key_vault_id              = optional(string)
    user_assigned_identity_id = optional(string)
  })
  description = "A customer_managed_key block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "share_properties" {
  type = object({
    cors_rule = optional(object({
      allowed_headers    = optional(list(string))
      allowed_methods    = optional(list(string))
      allowed_origins    = optional(list(string))
      exposed_headers    = optional(list(string))
      max_age_in_seconds = optional(number)
    }))
    retention_policy = optional(object({
      days = optional(number)
    }))
    smb = optional(object({
      versions                        = optional(string)
      authentication_types            = optional(string)
      kerberos_ticket_encryption_type = optional(string)
      channel_encryption_type         = optional(string)
      multichannel_enabled            = optional(bool)
    }))
  })
  description = "A share_properties block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "network_rules" {
  type = object({
    default_action             = optional(string)
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    private_link_access = optional(list(object({
      endpoint_resource_id = optional(string)
      endpoint_tenant_id   = optional(string)
    })))
  })
  description = "A network_rules block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "large_file_share_enabled" {
  type        = bool
  description = "Is Large File Share Enabled? (100TiB; https://techcommunity.microsoft.com/t5/azure/azure-storage-account-larger-file-shares/m-p/958940)."
  default     = null
}

variable "azure_files_authentication" {
  type = object({
    directory_type = optional(string)
    # active_directory = optional(list(object({
    #   storage_sid = optional(string)
    #   domain_name = optional(string)
    #   domain_sid = optional(string)
    #   domain_guid = optional(string)
    #   forest_name = optional(string)
    #   netbios_domain_name = optional(string)
    # })))
  })
  description = "An azure_files_authentication block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "routing" {
  type = object({
    publish_internet_endpoints  = optional(bool)
    publish_microsoft_endpoints = optional(bool)
    choice                      = optional(string)
  })
  description = "A routing block as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "queue_encryption_key_type" {
  type        = string
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  default     = "Service"

  validation {
    condition     = contains(["Service", "Account"], var.queue_encryption_key_type)
    error_message = "The queue_encryption_key_type value must be one of: 'Service', 'Account'."
  }
}

variable "table_encryption_key_type" {
  type        = string
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  default     = "Service"

  validation {
    condition     = contains(["Service", "Account"], var.table_encryption_key_type)
    error_message = "The table_encryption_key_type value must be one of: 'Service', 'Account'."
  }
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
  default     = false

  #   validation { #TODO
  #   }
}

variable "immutability_policy" {
  type = object({
    allow_protected_append_writes = optional(bool)
    state                         = optional(string)
    period_since_creation_in_days = optional(number)
  })
  description = "An immutability_policy block as defined above. This argument specifies the default account-level immutability policy which is inherited and applied to objects that do not possess an explicit immutability policy at the object level. The object-level immutability policy has higher precedence than the container-level immutability policy, which has a higher precedence than the account-level immutability policy."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "sas_policy" {
  type = object({
    expiration_period = optional(string)
    expiration_action = optional(string)
  })
  description = "A sas_policy block as defined above."
  default     = {}

  #   validation { #TODO
  #   }
}

variable "allowed_copy_scope" {
  type        = string
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink."
  default     = null

  validation {
    condition     = try(contains(["AAD", "PrivateLink"], var.allowed_copy_scope) || var.allowed_copy_scope == null, true)
    error_message = "The allowed_copy_scope value must be one of: 'AAD', 'PrivateLink' or null."
  }
}

variable "sftp_enabled" {
  description = "Boolean, enable SFTP for the storage account."
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}