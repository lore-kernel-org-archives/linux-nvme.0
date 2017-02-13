From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 10:14:37 +0100
Subject: [PATCH v3 11/16] lpfc: NVME Target: Receive buffer updates
In-Reply-To: <58a0d923.jjJfZZPzCO4ZQP5E%jsmart2021@gmail.com>
References: <58a0d923.jjJfZZPzCO4ZQP5E%jsmart2021@gmail.com>
Message-ID: <72a0cb72-35bf-eaf1-cf1a-2a1c87058438@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> NVME Target: Receive buffer updates
> 
> Allocates buffer pools and configures adapter interfaces to handle
> receive buffer (asynchronous FCP CMD ius, first burst data)
> from the adapter. Splits by protocol, etc.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>

I probably do _not_ want to know why 32G FC-NVMe needs to know about
FCFs ...

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
