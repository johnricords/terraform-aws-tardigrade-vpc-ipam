variable "vpc_ipam" {
  description = "Object of inputs for all IPAM configuration resources"
  type = object({
    ipam = optional(object({
      operating_regions = list(object({
        region_name = string
      }))
      tags        = optional(map(string))
      cascade     = optional(bool)
      description = optional(string)
    }))
    pools = optional(list(object({
      name                              = string
      address_family                    = optional(string)
      allocation_default_netmask_length = optional(number)
      allocation_max_netmask_length     = optional(number)
      allocation_min_netmask_length     = optional(number)
      allocation_resource_tags          = optional(map(string))
      auto_import                       = optional(bool)
      aws_service                       = optional(bool)
      description                       = optional(string)
      ipam_scope_name                   = optional(string)
      ipam_scope_id                     = optional(string)
      locale                            = optional(string)
      publicly_advertisable             = optional(bool)
      public_ip_source                  = optional(string)
      source_ipam_pool_id               = optional(string)
      tags                              = optional(map(string))
    })), [])
    pool_cidrs = optional(list(object({
      name = string
      cidr = optional(string)
      cidr_authorization_context = optional(object({
        cidr_authorization_context_message   = optional(string)
        cidr_authorization_context_signature = optional(string)
      }))
      ipam_pool_id   = string
      netmask_length = optional(number)
    })), [])
    pool_cidr_allocations = optional(list(object({
      cidr             = optional(string)
      description      = optional(string)
      disallowed_cidrs = optional(list(string))
      ipam_pool_id     = string
      netmask_length   = optional(number)
    })), [])
    preview_next_cidr = optional(object({
      disallowed_cidrs = optional(list(string))
      ipam_pool_id     = string
      netmask_length   = optional(number)
    }))
    scopes = optional(list(object({
      name        = string
      description = optional(string)
      tags        = optional(map(string))
    })), [])
  })
}
