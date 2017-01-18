From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 08:08:53 +0100
Subject: [PATCH 03/17] lpfc: NVME Initiator: Base modifications Part B
In-Reply-To: <587ec2ee.01djIfQsSlhQj6k1%jsmart2021@gmail.com>
References: <587ec2ee.01djIfQsSlhQj6k1%jsmart2021@gmail.com>
Message-ID: <59244b8d-3176-9d50-910c-62e48e411d88@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This is part B of parts A..F.
> 
> Part B is limited to lpfc_attr.c: lpfc attribute modifications
> 
> *********
> 
> Refer to Part A for a description of base modifications
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_attr.c | 448 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 405 insertions(+), 43 deletions(-)
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
