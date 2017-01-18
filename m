From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 08:21:13 +0100
Subject: [PATCH 05/17] lpfc: NVME Initiator: Base modifications Part D
In-Reply-To: <587ec2f0.FOr4W1UKpsGdXJmP%jsmart2021@gmail.com>
References: <587ec2f0.FOr4W1UKpsGdXJmP%jsmart2021@gmail.com>
Message-ID: <4ed90da6-7ae6-a4f4-a036-7a01f1ed8b39@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This is part D of parts A..F.
> 
> Part D is the 2nd half of the mods to lpfc_init.c. This is the location
> of most of changes for the following:
> - sli3 ring vs sli4 wq splits
> - buffer pools are allocated/freed
> - sgl pools allocated/freed
> - adapter resources split up
> - queue config decided and enacted
> - receive buffer management
> 
> *********
> 
> Refer to Part A for a description of base modifications
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 1088 +++++++++++++++++++++++------------------
>  1 file changed, 616 insertions(+), 472 deletions(-)
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
