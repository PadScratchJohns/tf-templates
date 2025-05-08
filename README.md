# What is this repo?
A collection of tf templates I have created across multiple cloud and hypervisor providers. 

# but... why?
As good as my memory is, having some working boilerplate templates helps lots.

# How to navigate.
The names of the parent folders is a brief run down of what the templates do, check the README in each folder for more.

# How to run
Add your own pipeline with auth method and run using the sampletfvars file as the input. Or use your own.

# Security stuff
gitignore in each root folder to make sure no .env/.tfstate/.tfvars are uploaded. 

I may upload a sample tfvars to prove out the templates. 

# provider versions - Located in main.tf in the root folder "modules"
AWS - aws 5.94 - https://github.com/hashicorp/terraform-provider-aws
Azure - azurerm 3.74 - https://github.com/hashicorp/terraform-provider-azurerm
GCP - google  - https://github.com/hashicorp/terraform-provider-google / https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_versions
Proxmox - proxmox 3.0.1-rc8 - https://github.com/Telmate/terraform-provider-proxmox / https://github.com/Telmate/terraform-provider-proxmox/blob/master/docs/index.md 

# Templates
As per the docs all of the templates here are module based. This is to provide a some what similar setup across the providers. 

# OpenTofu
At some point I will update the templates to use OpenTofu over Terraform. Currently most of the code is a drop in replacement but this requires a lot of changes to be checked first.

https://opentofu.org/docs/intro/migration/

# Liability
This code is provided as is and I will hold no responsibility for any issues that arise from the use of it. 
Don't be that guy and just test the templates and code in DEV/Staging first before rolling out to PRD...

# Authentication
This is left intentionally blank, as are the pipelines missing to run these templates. This is because in AWS I would use BitBucket pipelines or AWS DevOps, Azure I would use ADO etc...

Just be smart and use managed identitities here and not user accounts. 