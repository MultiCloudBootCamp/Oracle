## Setup below infra using IAC tool(Terraform)

[![Image](https://github.com/MultiCloudBootCamp/Oracle/tree/main/BootCamp_Challenges/Day1_Challenge/images/SolutionArchitect_Design.png)](https://github.com/MultiCloudBootCamp/Oracle/tree/main/BootCamp_Challenges/Day1_Challenge/images/SolutionArchitect_Design.png)

## Pre-requisites:

- Generate ssh-key by following:
  https://blogs.oracle.com/linux/post/creating-an-ssh-key-pair-on-the-linux-command-line-for-oci-access
  and replace "Publickey" in main.tf.Make sure you do not publish public&Private keys in repo.

- In common variable file replace:
   "networkcompartid"
   "computecompartmentid"


## Infra Provisioning Steps:
1. Open OCI cli command interface
2. Upload main.tf and common_variables.tf in oci cli.
3. Execute below terraform commands:
    - terraform init
    - terraform validate
    - terraform plan
    - terraform apply --auto-approve
4. Once provisioning is done, try to connect to your machine using ssh connection using your private key.
5. If everything is as expected you can destroy complete infra using " terraform destroy --auto-approve


## FYI:

- When we provision Virtual Cloud Network, by default we get
1. Default Route table
2. Default Security list
3. DHCP 