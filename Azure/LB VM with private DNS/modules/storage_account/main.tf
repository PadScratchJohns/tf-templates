resource "azurerm_storage_account" "storage_account" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name = var.storage_account_name

  resource_group_name = var.resource_group_name

  location = var.location

  account_kind             = var.account_kind
  account_tier             = contains(["BlockBlobStorage", "FileStorage"], var.account_kind) ? "Premium" : var.account_tier
  account_replication_type = var.account_replication_type

  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  access_tier                      = contains(["BlockBlobStorage", "FileStorage", "StorageV2"], var.account_kind) ? var.access_tier : null
  edge_zone                        = var.edge_zone
  enable_https_traffic_only        = var.enable_https_traffic_only
  min_tls_version                  = var.min_tls_version
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  is_hns_enabled                   = var.account_tier == "Standard" || (var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage") ? var.is_hns_enabled : null
  nfsv3_enabled                    = ((var.account_tier == "Standard" && var.account_kind == "StorageV2") || (var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage") && var.is_hns_enabled == true && var.enable_https_traffic_only == false) ? var.nfsv3_enabled : false

  dynamic "custom_domain" {
    for_each = var.custom_domain.name == tostring(null) ? [] : var.custom_domain[*]

    content {
      name          = custom_domain.value["name"]
      use_subdomain = custom_domain.value["use_subdomain"]
    }
  }

  dynamic "customer_managed_key" {
    for_each = (var.account_kind == "StorageV2" && var.identity[*].type == "UserAssigned") ? (var.customer_managed_key == tostring(null) ? [] : var.customer_managed_key[*]) : []

    content {
      key_vault_key_id          = customer_managed_key.value["key_vault_key_id"]
      user_assigned_identity_id = customer_managed_key.value["user_assigned_identity_id"]
    }

  }

  dynamic "identity" {
    for_each = var.identity[*]

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["type"] == "UserAssigned" || identity.value["type"] == "SystemAssigned, UserAssigned" ? identity.value["identity_ids"] : []
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties[*]

    content {

      dynamic "cors_rule" {
        for_each = blob_properties.value["cors_rule"] == null ? [] : blob_properties.value["cors_rule"][*]
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value["delete_retention_policy"] == null ? [] : blob_properties.value["delete_retention_policy"][*]

        content {
          days = delete_retention_policy.value["days"]
        }
      }

      versioning_enabled            = blob_properties.value["versioning_enabled"]
      change_feed_enabled           = blob_properties.value["change_feed_enabled"]
      change_feed_retention_in_days = blob_properties.value["change_feed_retention_in_days"]
      default_service_version       = blob_properties.value["default_service_version"]
      last_access_time_enabled      = blob_properties.value["last_access_time_enabled"]

      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value["container_delete_retention_policy"] == null ? [] : blob_properties.value["container_delete_retention_policy"][*]

        content {
          days = container_delete_retention_policy.value["days"]
        }
      }

    }
  }

  dynamic "queue_properties" {
    for_each = var.account_kind == "BlobStorage" ? var.queue_properties[*] : []

    content {
      dynamic "cors_rule" {
        for_each = queue_properties.value["cors_rule"] == null ? [] : queue_properties.value["cors_rule"][*]
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }

      dynamic "logging" {
        for_each = queue_properties.value["logging"] == null ? [] : queue_properties.value["logging"][*]
        content {
          delete                = logging.value["delete"]
          read                  = logging.value["read"]
          version               = logging.value["version"]
          write                 = logging.value["write"]
          retention_policy_days = logging.value["retention_policy_days"]
        }
      }

      dynamic "minute_metrics" {
        for_each = queue_properties.value["minute_metrics"] == null ? [] : queue_properties.value["minute_metrics"][*]
        content {
          enabled               = minute_metrics.value["enabled"]
          version               = minute_metrics.value["version"]
          include_apis          = minute_metrics.value["include_apis"]
          retention_policy_days = minute_metrics.value["retention_policy_days"]
        }
      }

      dynamic "hour_metrics" {
        for_each = queue_properties.value["hour_metrics"] == null ? [] : queue_properties.value["hour_metrics"][*]
        content {
          enabled               = hour_metrics.value["enabled"]
          version               = hour_metrics.value["version"]
          include_apis          = hour_metrics.value["include_apis"]
          retention_policy_days = hour_metrics.value["retention_policy_days"]
        }
      }
    }
  }

  dynamic "static_website" {
    # shared_access_key access needs to be enabled, otherwise the account will provision but not the static_website
    for_each = (var.account_kind == "BlockBlobStorage" || var.account_kind == "StorageV2") && var.shared_access_key_enabled == true ? var.static_website[*] : []

    content {
      index_document     = static_website.value["index_document"]
      error_404_document = static_website.value["error_404_document"]
    }
  }

  dynamic "share_properties" {
    for_each = (length(var.share_properties[*].cors_rule[*]) == 1 && length(var.share_properties[*].retention_policy[*]) == 1 && length(var.share_properties[*].smb[*]) == 1) ? [] : var.share_properties[*]

    content {
      dynamic "cors_rule" {
        for_each = share_properties.value["cors_rule"] == null ? [] : share_properties.value["cors_rule"][*]
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }

      dynamic "retention_policy" {
        for_each = share_properties.value["retention_policy"] == null ? [] : share_properties.value["retention_policy"][*]
        content {
          days = retention_policy.value["days"]
        }
      }

      dynamic "smb" {
        for_each = share_properties.value["smb"] == null ? [] : share_properties.value["smb"][*]

        content {
          versions                        = smb.value["versions"]
          authentication_types            = smb.value["authentication_types"]
          kerberos_ticket_encryption_type = smb.value["kerberos_ticket_encryption_type"]
          channel_encryption_type         = smb.value["channel_encryption_type"]
          multichannel_enabled            = smb.value["multichannel_enabled"]
        }
      }
    }

  }

#  dynamic "network_rules" {
#    for_each = var.network_rules.default_action == tostring(null) ? [] : var.network_rules[*]
#    content {
#      default_action             = network_rules.value["default_action"]
#      bypass                     = network_rules.value["bypass"]
#      ip_rules                   = network_rules.value["ip_rules"]
#      virtual_network_subnet_ids = network_rules.value["virtual_network_subnet_ids"]
#      dynamic "private_link_access" {
#        for_each = network_rules.value["private_link_access"] == null ? [] : network_rules.value["private_link_access"][*]
#        content {
#          endpoint_resource_id = private_link_access.value["endpoint_resource_id"]
#          endpoint_tenant_id   = private_link_access.value["endpoint_tenant_id"]
#        }
#      }
#    }
#  }

  large_file_share_enabled = var.large_file_share_enabled

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication.directory_type == tostring(null) ? [] : var.azure_files_authentication[*]

    content {
      directory_type = azure_files_authentication.value["directory_type"]


      #   dynamic "active_directory" { Documented but doesn't seem to be supported
      #     for_each = (azure_files_authentication.value["directory_type"] == "AD" && azure_files_authentication.value["directory_type"] != "AADKERB") ? azure_files_authentication.value["active_directory"] : []

      #     storage_sid         = active_directory.value["storage_sid"]
      #     domain_name         = active_directory.value["domain_name"]
      #     domain_sid          = active_directory.value["domain_sid"]
      #     domain_guid         = active_directory.value["domain_guid"]
      #     forest_name         = active_directory.value["forest_name"]
      #     netbios_domain_name = active_directory.value["netbios_domain_name"]
      #   }
    }

  }

  dynamic "routing" {
    for_each = var.routing[*]

    content {
      publish_internet_endpoints  = routing.value["publish_internet_endpoints"]
      publish_microsoft_endpoints = routing.value["publish_microsoft_endpoints"]
      choice                      = routing.value["choice"]
    }
  }

  queue_encryption_key_type = var.account_kind == "StorageV2" ? var.queue_encryption_key_type : "Service"
  table_encryption_key_type = var.account_kind == "StorageV2" ? var.table_encryption_key_type : "Service"

  infrastructure_encryption_enabled = var.account_kind == "StorageV2" || (var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage") ? var.infrastructure_encryption_enabled : false

  dynamic "immutability_policy" {
    for_each = var.immutability_policy.period_since_creation_in_days == tostring(null) ? [] : var.immutability_policy[*]

    content {
      allow_protected_append_writes = immutability_policy.value["allow_protected_append_writes"]
      state                         = immutability_policy.value["state"]
      period_since_creation_in_days = immutability_policy.value["period_since_creation_in_days"]
    }
  }

  dynamic "sas_policy" {
    for_each = var.sas_policy.expiration_period == tostring(null) ? [] : var.sas_policy[*]

    content {
      expiration_period = sas_policy.value["expiration_period"]
      expiration_action = sas_policy.value["expiration_action"]
    }
  }

  allowed_copy_scope = var.allowed_copy_scope

  sftp_enabled = var.is_hns_enabled == true ? var.sftp_enabled : false

  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "StorageAccount" }), var.tags)

}