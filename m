From: sim@linux.vnet.ibm.com (Narasimhan V)
Date: Tue, 20 Mar 2018 14:29:43 +0530
Subject: nguid for nvme over fabrics
Message-ID: <410a2655c6f5e4ed9e1c2af36b72f3ee@linux.vnet.ibm.com>

Hi,

I am trying nvme over fabrics, and found this: nguid is set to 0s by 
default for all devices.

So, nguid can be same (0s in this case) for multiple devices. Is this 
valid ?
Also, same nguid for multiple devices could be set, by the above 
scenario.
No errors/warnings from either the nvme initiator/target.

 From spec, I see this:
Namespace Globally Unique Identifier (NGUID): This field contains a 
128-bit value that is
globally  unique and assigned to  the  namespace  when  the  namespace  
is  created.  This  field
remains fixed throughout the life of the namespace and is preserved 
across namespace and
controller operations (e.g., controller reset,  namespace format, etc.).


-- 
Regards
Narasimhan V
