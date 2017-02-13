From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 10:17:17 +0100
Subject: [PATCH v3 13/16] lpfc: NVME Target: bind to nvmet_fc api
In-Reply-To: <58a0d925.kcLFILjOKj1r3hVd%jsmart2021@gmail.com>
References: <58a0d925.kcLFILjOKj1r3hVd%jsmart2021@gmail.com>
Message-ID: <9b84947c-e44d-b5b8-e61a-b994e4d9dd80@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> NVME Target: Tie in to NVME Fabrics nvmet_fc LLDD target api
> 
> Adds the routines to:
> - register and deregister the FC port as a nvmet-fc targetport
> - binding of nvme queues to adapter WQs
> - receipt and passing of NVME LS's to transport, sending transport response
> - receipt of NVME FCP CMD IUs, processing FCP target io data transmission
>   commands; transmission of FCP io response
> - Abort operations for tgt io exchanges
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
