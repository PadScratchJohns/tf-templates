resource "azurerm_private_dns_a_record" "private_dns_a_record" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                = var.private_dns_a_record_name
  resource_group_name = var.resource_group_name
  zone_name           = var.zone_name
  ttl                 = var.ttl
  records             = var.records
  tags                = merge(tomap({ "module_version" = "0.0.1", "type" = "PrivateDNSARecord" }), var.tags)
}