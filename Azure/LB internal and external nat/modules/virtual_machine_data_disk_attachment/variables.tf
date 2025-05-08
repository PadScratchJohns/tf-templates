variable "virtual_machine_id" {
  type        = string
  description = "The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[\\S]+/providers/Microsoft.Compute/virtualMachines/[\\S]+", var.virtual_machine_id))
    error_message = "The virtual_machine_id value must be in the resource UID format (e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/NE-DB_RG/providers/Microsoft.Compute/virtualMachines/ne-db-ha01-node01')."
  }
}

variable "managed_disk_id" {
  type        = string
  description = "The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[\\S]+/providers/Microsoft.Compute/disks/[\\S]+", var.managed_disk_id))
    error_message = "The managed_disk_id value must be in the resource UID format (e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/NE-DB_RG/providers/Microsoft.Compute/disks/ne-db-ha01-node01_osdisk')."
  }
}

variable "lun" {
  type        = number
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."

  validation {
    condition     = var.lun >= 0 && var.lun <= 10
    error_message = "The lun value must be a number between 0 and 10."
  }
}

variable "caching" {
  type        = string
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.caching)
    error_message = "The caching value must be one of: 'None', 'ReadOnly', 'ReadWrite'."
  }
}

variable "create_option" {
  type        = string
  description = "The Create Option of the Data Disk, such as Empty or Attach. Defaults to Attach. Changing this forces a new resource to be created."
  default     = "Attach"

  validation {
    condition     = contains(["Empty", "Attach"], var.create_option)
    error_message = "The create_option value must be one of: 'Empty', 'Attach'."
  }
}

variable "write_accelerator_enabled" {
  type        = bool
  description = "Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs. Defaults to false."
  default     = false
}