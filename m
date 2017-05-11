From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:18:16 +0200
Subject: [PATCH 04/15] lpfc: Fix nvmet RQ resource needs for large block
 writes.
In-Reply-To: <20170510190713.30171-5-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-5-jsmart2021@gmail.com>
Message-ID: <628697c5-6273-f87b-6f39-145bbeeb0741@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> Large block writes to the nvme target were failing because
> the default number of RQs posted was insufficient.
> 
> Expand the NVMET RQs to 2048 RQEs and ensure a minimun of 2048
                                                         512^^^^
> RQEs are posted, no matter how many MRQs are configured.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_attr.c  |  4 ++--
>  drivers/scsi/lpfc/lpfc_init.c  | 20 +++++++++++++++-----
>  drivers/scsi/lpfc/lpfc_nvmet.c |  2 +-
>  drivers/scsi/lpfc/lpfc_nvmet.h |  1 +
>  drivers/scsi/lpfc/lpfc_sli.c   | 18 ++++++++++--------
>  drivers/scsi/lpfc/lpfc_sli4.h  |  1 +
>  6 files changed, 30 insertions(+), 16 deletions(-)
> > diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 41ec7451689b..ee4d9be95960 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -60,9 +60,9 @@
>  #define LPFC_MIN_DEVLOSS_TMO	1
>  #define LPFC_MAX_DEVLOSS_TMO	255
>  
> -#define LPFC_DEF_MRQ_POST	256
> +#define LPFC_DEF_MRQ_POST	512
>  #define LPFC_MIN_MRQ_POST	32
> -#define LPFC_MAX_MRQ_POST	512
> +#define LPFC_MAX_MRQ_POST	2048
>  
The minimum is actually 512, isn't it?

Otherwise:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
