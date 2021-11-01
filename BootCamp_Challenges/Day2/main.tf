terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
      version = ">=4.0.0"
    }
  }
}

provider "oci" {
  # Configuration options
}


resource "oci_core_vcn" "contoso_vcn" {
    compartment_id = var.NetworkCompartment
    cidr_blocks = [ "10.1.0.0/16" ]
    display_name = var.vcn_display_name

}

resource "oci_core_subnet" "contoso_subnet" {
    cidr_block = var.subnet_cidr_block
    compartment_id = var.NetworkCompartment
    vcn_id = oci_core_vcn.contoso_vcn.id
    display_name = var.subnet_display_name
    prohibit_public_ip_on_vnic = false

}

resource "oci_core_internet_gateway" "contoso_internet_gateway" {
    #Required
    compartment_id = var.NetworkCompartment
    vcn_id = oci_core_vcn.contoso_vcn.id
    display_name = "contoso_internetgateway"

}


resource "oci_core_route_table" "test_route_table" {
      compartment_id = var.NetworkCompartment
       vcn_id = oci_core_vcn.contoso_vcn.id
       display_name = "contosoroutetable"
       route_rules {
           destination = "0.0.0.0/0"
           destination_type = "CIDR_BLOCK"
           network_entity_id = oci_core_internet_gateway.contoso_internet_gateway.id
       }
}

resource "oci_core_instance" "compute_instance" {
    count = 2
    availability_domain = var.instance_availability_domain
    compartment_id = var.ComputeCompartment
    display_name = "Webserver${count.index}"
    shape = "VM.Standard.E2.1.Micro"
    create_vnic_details {
        subnet_id = oci_core_subnet.contoso_subnet.id        
        display_name = "primaryVNIC"
        assign_public_ip = true
    }
    source_details {
      source_type = "image"
      source_id = var.compute_image_id
    }
    metadata = {
        ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwZXW0mTCvNGVN8UZS8vRcyPBajDt9AB10ZHn7Dsooz4jXbmCx4OIyavzmqlfBbMuYXVYGTCbHk28f5Rpb+yrRQJct9ckQaB2HTcE8vPZCGEYz4xFbhI2Ls67VfrtJSk6kxAAHW8rKz/aZzSp2G0GSsooAJDrSg9Y2RPqnHCd9XRcbAFe3vFdJ9Wp1gTP5Y/V3KagLY1C3Y6/xJWXCpalboEZxb0OTvhxJ6gHgw2SG7cgs1LJZyUbjlBdc6C8FJ3p3n8LDfzu3GF0K+aofVaqNKAJdgfibGWdIfKXuOntGdJias6D4CWsJFUHr38sVdaqNbkp1PDqDf/pkl4SDzWRRsFZJJe0RVIJ06O7ZoJaDRJ9uWsIfEH/NF9yBmb2Z2NZFkSUz+7HStYRFO3Ic9TkKa9Fy+1RPJBZC1oiYO0Gmp2vLNbIyVk5WnoqjGDnc8ih2uzUd4sHytwkX1DHFd7LPMEWGRL71L404iHjqGlF0zt4233Lx76wgW0V3IxxRdss= fareast\\ombirade@MININT-7V3ASPE"
    }
}