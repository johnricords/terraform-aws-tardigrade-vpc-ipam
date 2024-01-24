# terraform-aws-tardigrade-vpc-ipam

## POOLS variable 
It is important that you specify the `ipam_scope_name` attribute to match either "public_default_scope",  "private_default_scope", or exact match to your `vpc_ipam.scopes.name` input on the first module call. Once you've created your scopes by name, then you can reference by id in subsequent module calls. You may also provide `ipam_scope_id` instead of `ipam_scope_name`. The two are mutually exclusive, do not provide both. 

Managing a hierarchy of pools can be a bit tricky. You'll need to call the module successively to build up the structure, chaining the outputs together.  

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.40.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_ipam"></a> [vpc\_ipam](#input\_vpc\_ipam) | Object of inputs for all IPAM configuration resources | <pre>object({<br>    ipam = optional(object({<br>      operating_regions = list(object({<br>        region_name = string<br>      }))<br>      tags        = optional(map(string))<br>      cascade     = optional(bool)<br>      description = optional(string)<br>    }))<br>    pools = optional(list(object({<br>      name                              = string<br>      address_family                    = optional(string)<br>      allocation_default_netmask_length = optional(number)<br>      allocation_max_netmask_length     = optional(number)<br>      allocation_min_netmask_length     = optional(number)<br>      allocation_resource_tags          = optional(map(string))<br>      auto_import                       = optional(bool)<br>      aws_service                       = optional(bool)<br>      description                       = optional(string)<br>      ipam_scope_name                   = optional(string)<br>      ipam_scope_id                     = optional(string)<br>      locale                            = optional(string)<br>      publicly_advertisable             = optional(bool)<br>      public_ip_source                  = optional(string)<br>      source_ipam_pool_id               = optional(string)<br>      tags                              = optional(map(string))<br>    })), [])<br>    pool_cidrs = optional(list(object({<br>      name = string<br>      cidr = optional(string)<br>      cidr_authorization_context = optional(object({<br>        cidr_authorization_context_message   = optional(string)<br>        cidr_authorization_context_signature = optional(string)<br>      }))<br>      ipam_pool_id   = string<br>      netmask_length = optional(number)<br>    })), [])<br>    pool_cidr_allocations = optional(list(object({<br>      cidr             = optional(string)<br>      description      = optional(string)<br>      disallowed_cidrs = optional(list(string))<br>      ipam_pool_id     = string<br>      netmask_length   = optional(number)<br>    })), [])<br>    preview_next_cidr = optional(object({<br>      disallowed_cidrs = optional(list(string))<br>      ipam_pool_id     = string<br>      netmask_length   = optional(number)<br>    }))<br>    scopes = optional(list(object({<br>      name        = string<br>      description = optional(string)<br>      tags        = optional(map(string))<br>    })), [])<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipam"></a> [ipam](#output\_ipam) | Object of all AWS VPC IPAM |
| <a name="output_pool_cidr"></a> [pool\_cidr](#output\_pool\_cidr) | Map of VPC IPAM Pool Cidrs objects |
| <a name="output_pools"></a> [pools](#output\_pools) | Map of VPC IPAM Pool Objects |
| <a name="output_scopes"></a> [scopes](#output\_scopes) | Map of VPC IPAM Scope objects |

<!-- END TFDOCS -->
