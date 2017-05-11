From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:22:08 +0200
Subject: [PATCH 07/15] lpfc: Separate NVMET data buffer pool fir ELS/CT.
In-Reply-To: <20170510190713.30171-8-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-8-jsmart2021@gmail.com>
Message-ID: <80a3544a-6bad-e56f-9c0e-1b2f24b509cd@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> Using 2048 byte buffer and onle 128 bytes is needed.
> 
> Create nee LFPC_NVMET_DATA_BUF_SIZE define to use
> for NVMET RQ/MRQs.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h      |  1 +
>  drivers/scsi/lpfc/lpfc_crtn.h |  1 +
>  drivers/scsi/lpfc/lpfc_hw4.h  |  1 +
>  drivers/scsi/lpfc/lpfc_init.c |  7 ++++++-
>  drivers/scsi/lpfc/lpfc_mem.c  | 33 ++++++++++++++++++++++++++-------
>  drivers/scsi/lpfc/lpfc_sli.c  | 19 +++++++++++++++----
>  6 files changed, 50 insertions(+), 12 deletions(-)
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
