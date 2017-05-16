From: hare@suse.de (Hannes Reinecke)
Date: Tue, 16 May 2017 09:00:27 +0200
Subject: [PATCH v2 04/15] lpfc: Fix nvmet RQ resource needs for large
 block writes.
In-Reply-To: <20170515222052.26004-5-jsmart2021@gmail.com>
References: <20170515222052.26004-1-jsmart2021@gmail.com>
 <20170515222052.26004-5-jsmart2021@gmail.com>
Message-ID: <31ea2268-bb8a-047e-1c62-5cd3a59d622f@suse.de>

On 05/16/2017 12:20 AM, James Smart wrote:
> Large block writes to the nvme target were failing because
> the default number of RQs posted was insufficient.
> 
> Expand the NVMET RQs to 2048 RQEs and ensure a minimum of 512
> RQEs are posted, no matter how many MRQs are configured.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2:
>  set minimum mrq post to 512
>  merged parts of fixup patch 0012 into the patch:
>    rq/mrq entry_repost values
> 
>  drivers/scsi/lpfc/lpfc_attr.c  |  6 +++---
>  drivers/scsi/lpfc/lpfc_init.c  | 23 +++++++++++++-------
>  drivers/scsi/lpfc/lpfc_nvmet.c |  2 +-
>  drivers/scsi/lpfc/lpfc_nvmet.h |  1 +
>  drivers/scsi/lpfc/lpfc_sli.c   | 49 +++++++++---------------------------------
>  drivers/scsi/lpfc/lpfc_sli4.h  |  2 +-
>  6 files changed, 31 insertions(+), 52 deletions(-)
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
