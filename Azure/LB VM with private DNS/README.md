# Intro
This is a simple x number of VM's linked with a LB into a backend pool.

# Uses
My use here is the application layer of the 3 tier architecture, so what the presentation layer sends from and handles the main logic of the software. 

Loadbalanced for HA reasons with probes.

# Considerations
My default is to have sticky sessions enabled for session persistance.