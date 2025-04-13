# Intro
This is an Azure Gateway Ingress Controller, that handles SSL offloading and passes traffic to an AKS cluster. This does some protocol transformation and hands off to another service. 

# Uses
The main use of this solution is to take WSS and convert it to plain SIP, the AGIC does SSL offloading, and containerised Janus WebRTC gateway in AKS manages the WS-SIP transformations and back again. 

This handles the main routing over public IP's - no NAT here, that is done at the Kamailio/RTPengine layer. AGIC needed as it is an app gateway that can handle http upgrades to WS connections. 

# Considerations
My default is to have sticky sessions enabled for session persistance. Containerised Janus are standalone so no message queue or sharing state here. 