From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 09:02:02 +0100
Subject: [PATCH 12/17] lpfc: NVME Target: Receive buffer updates
In-Reply-To: <587ec2f7.pbBec53dehsFNPMw%jsmart2021@gmail.com>
References: <587ec2f7.pbBec53dehsFNPMw%jsmart2021@gmail.com>
Message-ID: <78a1e297-2f89-caf7-d4c2-ef0129420d14@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Target: Receive buffer updates
> 
> Allocates buffer pools and configures adapter interfaces to handle
> receive buffer (asynchronous FCP CMD ius, first burst data)
> from the adapter. Splits by protocol, etc.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h      |   3 +
>  drivers/scsi/lpfc/lpfc_attr.c |  86 +++++-
>  drivers/scsi/lpfc/lpfc_crtn.h |   1 +
>  drivers/scsi/lpfc/lpfc_hw4.h  | 274 +++++++++++++++++++
>  drivers/scsi/lpfc/lpfc_init.c | 264 +++++++++++++++++-
>  drivers/scsi/lpfc/lpfc_mbox.c |  87 ++++++
>  drivers/scsi/lpfc/lpfc_sli.c  | 608 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/scsi/lpfc/lpfc_sli4.h |  11 +
>  8 files changed, 1313 insertions(+), 21 deletions(-)
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
