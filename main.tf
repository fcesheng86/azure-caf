data "azurerm_client_config" "core" {}
variable "root_id" {
  type    = string
  default = "myorg"
}

variable "root_name" {
  type    = string
  default = "My Organization"
}
# Call the caf-enterprise-scale module directly from the Terraform Registry
# pinning to the latest version

# resource "azurerm_management_group" "sample_mgmt_grp" {
#   display_name = "mysampleorg"
#   name         = "mysampleorg"
# }

# resource "azurerm_management_group" "child_mgmt_grp" {
#   display_name = "myorg-online-example-1"
#   name         = "myorg-online-example-1"
#   parent_management_group_id = azurerm_management_group.sample_mgmt_grp.id
# }


module "caf-enterprise-scale" {
  source           = "Azure/caf-enterprise-scale/azurerm"
  version          = "5.0.3"
  default_location = "eastus"
  root_parent_id   = data.azurerm_client_config.core.tenant_id
  root_id          = "myorg"
  root_name        = "My Organization"

  library_path = "${path.root}/customlib"

  deploy_core_landing_zones = false
  custom_landing_zones = {
    "mysampleorg" = {
      display_name               = "${upper(var.root_id)} Example 1"
      parent_management_group_id = ""
      subscription_ids = [
        #insert your subscription here
      ]
      archetype_config = {
        archetype_id   = "example_archetype"
        parameters     = {}
        access_control = {}
      }
    }
  }

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }
}

output "scope" {
  value = module.caf-enterprise-scale.scope_id
}

output "root_id" {
  value = module.caf-enterprise-scale.root_id
}
