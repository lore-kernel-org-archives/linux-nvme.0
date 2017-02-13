From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 09:59:57 +0100
Subject: [PATCH v3 08/16] lpfc: NVME Initiator: bind to nvme_fc api
In-Reply-To: <58a0d920.BHYSqh6Jz9Hoai1s%jsmart2021@gmail.com>
References: <58a0d920.BHYSqh6Jz9Hoai1s%jsmart2021@gmail.com>
Message-ID: <75bdcb47-789e-7cbe-7c12-b7427c9ee7a4@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> NVME Initiator: Tie in to NVME Fabrics nvme_fc LLDD initiator api
> 
> Adds the routines to:
> - register and deregister the FC port as a nvme-fc initiator localport
> - register and deregister remote FC ports as a nvme-fc remoteport
> - binding of nvme queues to adapter WQs
> - send/perform NVME LS's
> - send/perform NVME FCP initiator io operations
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
