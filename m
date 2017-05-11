From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 09:24:32 +0200
Subject: [PATCH 09/15] lpfc: Added recovery logic for running out of NVMET
 IO context resources
In-Reply-To: <20170510190713.30171-10-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-10-jsmart2021@gmail.com>
Message-ID: <68a8269e-2b82-0e5b-a34e-a0b53da9dfe8@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> Previous logic would just drop the IO
> 
> Added logic to queue the IO to wait for an IO context resource from an IO
> thats already in progress.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h         |   1 +
>  drivers/scsi/lpfc/lpfc_attr.c    |   6 ++
>  drivers/scsi/lpfc/lpfc_crtn.h    |   2 +
>  drivers/scsi/lpfc/lpfc_debugfs.c |   6 ++
>  drivers/scsi/lpfc/lpfc_init.c    |   2 +
>  drivers/scsi/lpfc/lpfc_nvmet.c   | 138 +++++++++++++++++++++++++++++++++------
>  drivers/scsi/lpfc/lpfc_sli.c     |   7 +-
>  drivers/scsi/lpfc/lpfc_sli4.h    |   6 +-
>  8 files changed, 144 insertions(+), 24 deletions(-)
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
