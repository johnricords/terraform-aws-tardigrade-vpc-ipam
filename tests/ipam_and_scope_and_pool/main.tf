resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

module "create_ipam" {
  source = "../.."

  vpc_ipam = {
    ipam = {
      name = "default_ipam"
      operating_regions = [
        { region_name = "us-east-1" },
        { region_name = "us-west-1" }
      ]
      cascade     = true
      description = random_string.this.result
    }
    scopes = [
      {
        name        = "high_level_container"
        description = random_string.this.result
        tags = {
          name = "broker_managed"
        }
      },
    ]
    pools = [
      {
        name                              = "pool_of_cidrs"
        address_family                    = "ipv4"
        allocation_default_netmask_length = "16"
        allocation_min_netmask_length     = "16"
        allocation_max_netmask_length     = "16"
        description                       = random_string.this.result
        ipam_scope_name                   = "private_default_scope"
        locale                            = "us-east-1"
        tags = {
          name = "broker_managed"
        }
      },
    ]
  }
}
