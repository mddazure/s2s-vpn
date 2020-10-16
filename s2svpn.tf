provider "azurerm" {
version = "=2.0"
features {}
}
Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "s2srg"
  location = "West Central US"
}



# Create a virtual network within the resource group
resource "azurerm_virtual_network" "q1" {
  name                = "q1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["192.168.1.0/24"]
  
}
resource "azurerm_subnet" "q1-subnet1"{
      name = "subnet1"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q1.name
      address_prefix = "192.168.1.0/26"
  }
  resource "azurerm_subnet" "q1-subnet2"{
      name = "subnet2"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q1.name
      address_prefix = "192.168.1.64/26"
  }
  resource "azurerm_subnet" "q1-GatewaySubnet"{
      name = "GatewaySubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q1.name
            address_prefix = "192.168.1.240/28"
  }
  resource "azurerm_subnet" "q1-bastionsubnet"{
      name = "AzureBastionSubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q1.name
            address_prefix = "192.168.1.224/28"
  }
resource "azurerm_public_ip" "q1-gw-pubip" {
  name                = "q1-gw-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}
resource "azurerm_virtual_network_gateway" "q1-gw" {
  name                = "q1-gw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "q1-gwGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.q1-gw-pubip.id
    subnet_id                     = azurerm_subnet.q1-GatewaySubnet.id
  }
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "q2" {
  name                = "q2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["192.168.2.0/24"]
  
}
resource "azurerm_subnet" "q2-subnet1"{
      name = "subnet1"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q2.name
      address_prefix = "192.168.2.0/26"
  }
  resource "azurerm_subnet" "q2-subnet2"{
      name = "subnet2"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q2.name
      address_prefix = "192.168.2.64/26"
  }
  resource "azurerm_subnet" "q2-GatewaySubnet"{
      name = "GatewaySubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.q2.name
            address_prefix = "192.168.2.240/28"
  }

resource "azurerm_public_ip" "q2-gw-pubip" {
  name                = "q2-gw-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}
resource "azurerm_virtual_network_gateway" "q2-gw" {
  name                = "q2-gw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "q2-gwGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.q2-gw-pubip.id
    subnet_id                     = azurerm_subnet.q2-GatewaySubnet.id
  }
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "qhub" {
  name                = "qhub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["192.168.0.0/24"]
  
}
resource "azurerm_subnet" "qhub-subnet1"{
      name = "subnet1"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qhub.name
      address_prefix = "192.168.0.0/26"
  }
  resource "azurerm_subnet" "qhub-subnet2"{
      name = "subnet2"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qhub.name
      address_prefix = "192.168.0.64/26"
  }
  resource "azurerm_subnet" "qhub-GatewaySubnet"{
      name = "GatewaySubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qhub.name
            address_prefix = "192.168.0.240/28"
  }

resource "azurerm_public_ip" "qhub-gw-pubip" {
  name                = "qhub-gw-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}
resource "azurerm_virtual_network_gateway" "qhub-gw" {
  name                = "qhub-gw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "qhub-gwGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.qhub-gw-pubip.id
    subnet_id                     = azurerm_subnet.qhub-GatewaySubnet.id
  }
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "qonprem" {
  name                = "qonprem"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["192.168.100.0/24"]
  
}
resource "azurerm_subnet" "qonprem-subnet1"{
      name = "subnet1"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qonprem.name
      address_prefix = "192.168.100.0/26"
  }
resource "azurerm_subnet" "qonprem-subnet2"{
      name = "subnet2"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qonprem.name
      address_prefix = "192.168.100.64/26"
  }
resource "azurerm_subnet" "qonprem-GatewaySubnet"{
      name = "GatewaySubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qonprem.name
            address_prefix = "192.168.100.240/28"
  }
resource "azurerm_public_ip" "qonprem-gw-pubip" {
  name                = "qonprem-gw-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}
resource "azurerm_virtual_network_gateway" "qonprem-gw" {
  name                = "qonprem-gw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "qonprem-gwGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.qonprem-gw-pubip.id
    subnet_id                     = azurerm_subnet.qonprem-GatewaySubnet.id
  }
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "qremote" {
  name                = "qremote"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.1.0/24"]
  
}
resource "azurerm_subnet" "qremote-subnet1"{
      name = "subnet1"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qremote.name
      address_prefix = "10.0.1.0/26"
  }
resource "azurerm_subnet" "qremote-subnet2"{
      name = "subnet2"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qremote.name
      address_prefix = "10.0.1.64/26"
  }
resource "azurerm_subnet" "qremote-GatewaySubnet"{
      name = "GatewaySubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qremote.name
            address_prefix = "10.0.1.240/28"
  }
resource "azurerm_subnet" "qremote-bastionsubnet"{
      name = "AzureBastionSubnet"
      resource_group_name = azurerm_resource_group.rg.name
      virtual_network_name = azurerm_virtual_network.qremote.name
            address_prefix = "10.0.1.224/28"
  }
resource "azurerm_public_ip" "qremote-gw-pubip" {
  name                = "qremote-gw-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}
resource "azurerm_virtual_network_gateway" "qremote-gw" {
  name                = "qremote-gw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "qremote-gwGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.qremote-gw-pubip.id
    subnet_id                     = azurerm_subnet.qremote-GatewaySubnet.id
  }
}
#Create s2svpn connection pair
resource "azurerm_virtual_network_gateway_connection" "q1-hub" {
  name                = "q1-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.q1-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.qhub-gw.id

  shared_key = "Nienke0405"
}
resource "azurerm_virtual_network_gateway_connection" "hub-q1" {
  name                = "hub-q1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.qhub-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.q1-gw.id

  shared_key = "Nienke0405"
}
#Create s2svpn connection pair
resource "azurerm_virtual_network_gateway_connection" "q2-hub" {
  name                = "q2-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.q2-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.qhub-gw.id

  shared_key = "Nienke0405"
}
resource "azurerm_virtual_network_gateway_connection" "hub-q2" {
  name                = "hub-q2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.qhub-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.q2-gw.id

  shared_key = "Nienke0405"
}
#Create s2svpn connection pair
resource "azurerm_virtual_network_gateway_connection" "onprem-hub" {
  name                = "onprem-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.qonprem-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.qhub-gw.id

  shared_key = "Nienke0405"
}
resource "azurerm_virtual_network_gateway_connection" "hub-onprem" {
  name                = "hub-onprem"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.qhub-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.qonprem-gw.id

  shared_key = "Nienke0405"
}
#Create s2svpn connection pair
resource "azurerm_virtual_network_gateway_connection" "onprem-remote" {
  name                = "onprem-remote"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.qonprem-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.qremote-gw.id

  shared_key = "Nienke0405"
}
resource "azurerm_virtual_network_gateway_connection" "remote-onprem" {
  name                = "remote-onprem"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.qremote-gw.id
  peer_virtual_network_gateway_id   = azurerm_virtual_network_gateway.qonprem-gw.id

  shared_key = "Nienke0405"
}
#create network interfaces
resource "azurerm_network_interface" "q1-nic" {
  name                = "q1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.q1-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "qremote-nic" {
  name                = "qremote-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.qremote-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
#create vms
resource "azurerm_linux_virtual_machine" "q1" {
  name                = "q1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "marc"
  disable_password_authentication = false
   admin_password = "Nienke040598"
  network_interface_ids = [
    azurerm_network_interface.q1-nic.id,
  ]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
resource "azurerm_linux_virtual_machine" "qremote" {
  name                = "qremote"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "marc"
  disable_password_authentication = false
   admin_password = "Nienke040598"
  network_interface_ids = [
    azurerm_network_interface.qremote-nic.id,
  ]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
#create bastion
resource "azurerm_public_ip" "qremote-bastion-pubip" {
  name                = "qremote-bastion-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"
  allocation_method = "Static"
}
resource "azurerm_public_ip" "q1-bastion-pubip" {
  name                = "q1-bastion-pubip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"
  allocation_method = "Static"
}
resource "azurerm_bastion_host" "q1-bastion" {
  name                = "q1-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.q1-bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.q1-bastion-pubip.id
  }
}
resource "azurerm_bastion_host" "qremote-bastion" {
  name                = "qremote-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.qremote-bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.qremote-bastion-pubip.id
  }
}