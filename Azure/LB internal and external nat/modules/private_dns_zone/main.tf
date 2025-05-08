resource "azurerm_private_dns_zone" "private_dns_zone" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"], tags["24Hours"] # DNS zones don't support a load of tag names for some reason
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name

  dynamic "soa_record" {
    for_each = var.soa_record[*]

    content {
      email        = soa_record.value["email"]
      expire_time  = soa_record.value["expire_time"]
      minimum_ttl  = soa_record.value["minimum_ttl"]
      refresh_time = soa_record.value["refresh_time"]
      retry_time   = soa_record.value["retry_time"]
      ttl          = soa_record.value["ttl"]
      tags         = soa_record.value["tags"]
    }

  }

  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "PrivateDNSZone" }), var.tags)

}