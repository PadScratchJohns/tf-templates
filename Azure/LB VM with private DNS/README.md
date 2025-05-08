# Intro
This is a simple x number of VM's linked with a LB into a backend pool.

In this specific example its main use was an internal LB to 3 x HAProxy nodes, 3 DBNodes, a Homer Sipcapture VM and a SaltMaster VM. This is also the home for the private DNS zone as well. 

VNET linking to different RG's and Private DNS linking as well. 

# Uses
My use here is the application layer of the 3 tier architecture, so what the presentation layer sends from and handles the main logic of the software. 

Loadbalanced for HA reasons with probes.

# Considerations
My default is to have sticky sessions enabled for session persistance on the LB. 