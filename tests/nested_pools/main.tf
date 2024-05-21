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
      },
    ]
  }
}

module "create_pool" {
  source = "../.."

  vpc_ipam = {

    pools = [
      {
        name                              = "pool_of_cidrs"
        address_family                    = "ipv4"
        allocation_default_netmask_length = "16"
        allocation_min_netmask_length     = "16"
        allocation_max_netmask_length     = "16"
        description                       = random_string.this.result
        locale                            = "us-east-1"

        ipam_scope_id = module.create_ipam.scopes["high_level_container"].id
      },
    ]
  }
}

module "create_child_pool" {
  source = "../.."

  vpc_ipam = {
    pools = [
      {
        name                              = "child_of_pool_of_cidrs"
        address_family                    = "ipv4"
        allocation_default_netmask_length = "16"
        allocation_min_netmask_length     = "16"
        allocation_max_netmask_length     = "16"
        description                       = random_string.this.result
        locale                            = "us-east-1"

        ipam_scope_id       = module.create_ipam.scopes["high_level_container"].id
        source_ipam_pool_id = module.create_pool.pools["pool_of_cidrs"].id
      },
    ]
  }
}
