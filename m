From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:18:58 +0200
Subject: [PATCH 05/15] lpfc: Fix NVMEI driver not decrementing counter
 causing bad rport state.
In-Reply-To: <20170510190713.30171-6-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-6-jsmart2021@gmail.com>
Message-ID: <f7328a57-bd4d-37cb-ba76-0e028198fbb9@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> During driver boot, a latency in the NVMET driver
> side causes the incoming NVMEI PRLI to get rejected by the
> NVMET driver.  When this happens, the NVMEI driver runs
> out of PRLI retries.  Bouncing the link does not fix the
> situation.
> 
> If the NVMEI driver decides, on PRLI completion
> failures, to retry the PRLI, always decrement the
> fc4_prli_sent counter.  This allows the PRLI completion
> to resolve to UNMAPPED when NVMET rejects the PRLI.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_els.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
