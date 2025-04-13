# Intro
As the name suggests this is a simple template that creates x amount of VM's with an additional data disk and links the vnet to another one. 

This also links to a private DNS zone in Azure as well.

# Uses
Main uses are a simple cluster of VM's that link to a central DB in another VNET following the 3 tier architecture principles.

# Considerations
These templates are for use in a zonal region - I will try update them to be compatible with non zonal regions, but availablility sets will not be added here so YMMV.
