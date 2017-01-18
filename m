From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 08:35:52 +0100
Subject: [PATCH 07/17] lpfc: NVME Initiator: Base modifications Part F
In-Reply-To: <587ec2f2.fmE2wQTjIBsi69sa%jsmart2021@gmail.com>
References: <587ec2f2.fmE2wQTjIBsi69sa%jsmart2021@gmail.com>
Message-ID: <96a2c350-8c20-491f-40a8-ec3dee77f597@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This is part F of parts A..F.
> 
> Part F is limited to lpfc_debugfs.[ch]. It contains the modifications in
> the existing debugfs snippets to work with the base modifications.
> 
> *********
> 
> Refer to Part A for a description of base modifications
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_debugfs.c | 535 +++++++++++++++++++++------------------
>  drivers/scsi/lpfc/lpfc_debugfs.h |  69 ++---
>  2 files changed, 324 insertions(+), 280 deletions(-)
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
