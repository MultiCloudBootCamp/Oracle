variable "NetworkCompartment" {
    default = "ocid1.compartment.oc1..aaaaaaaascut6thjtid6vt2mrlflbahbdf526ic7zfrcciakmleryxigt3vq"
    type = string
    description = "Network Compartment" 
    sensitive = true   
  
}
variable "ComputeCompartment" {
    default = "ocid1.compartment.oc1..aaaaaaaaeokbnjqonexonv3aa5abchgydti6ydwj6zqycjmz4n4riohaeq2a"
    type = string
    description = "Network Compartment" 
    sensitive = true   
  
}

variable "vcn_display_name" {
    default = "Contoso_VCN"
    type = string
    description = "OCI Virtual Cloud Network"
  
}

#region Subnet
variable "subnet_display_name" {
    default = "SubnetA"
    type = string
    description = "This is contoso's public subnetA"
    
}
variable "subnet_cidr_block" {
    default = "10.1.24.0/24"
    type = string
    description = "subnetA CIDR"
  
}
#endregion

#region Compute instance
variable "instance_availability_domain" {
    default = "QLzX:AP-HYDERABAD-1-AD-1"
  
}

variable "compute_image_id" {
    default = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaabdukecj2l3hkplgu3zq7cja7pjqdiiu4vtltzyjwkojw3mqhtfya"
    type = string
    description = "Oracle-Linux-7.9-2021.10.04-0 ID based on region"
    sensitive = true
  
}