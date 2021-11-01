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
    availability_domain = var.instance_availability_domain
    compartment_id = var.ComputeCompartment
    display_name = "Webserver1"
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
        ssh_authorized_keys = "<Publickey>"
    }
}