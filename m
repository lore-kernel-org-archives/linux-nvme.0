From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 09:04:49 +0100
Subject: [PATCH 14/17] lpfc: NVME Target: bind to nvmet_fc api
In-Reply-To: <587ec2f9.rOjtCa/pEziRaN+m%jsmart2021@gmail.com>
References: <587ec2f9.rOjtCa/pEziRaN+m%jsmart2021@gmail.com>
Message-ID: <6ccefbdc-e08f-5dbc-36dc-b63154a96264@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Target: Tie in to NVME Fabrics nvmet_fc LLDD target api
> 
> Adds the routines to:
> - register and deregister the FC port as a nvmet-fc targetport
> - binding of nvme queues to adapter WQs
> - receipt and passing of NVME LS's to transport, sending transport response
> - receipt of NVME FCP CMD IUs, processing FCP target io data transmission
>   commands; transmission of FCP io response.
> - Abort operations for tgt io exchanges.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/Makefile       |    2 +-
>  drivers/scsi/lpfc/lpfc_crtn.h    |    8 +
>  drivers/scsi/lpfc/lpfc_ct.c      |    2 +-
>  drivers/scsi/lpfc/lpfc_els.c     |    5 +-
>  drivers/scsi/lpfc/lpfc_hbadisc.c |   10 +-
>  drivers/scsi/lpfc/lpfc_init.c    |    2 +-
>  drivers/scsi/lpfc/lpfc_nvmet.c   | 1365 ++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/lpfc/lpfc_sli.c     |    8 +-
>  8 files changed, 1390 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/scsi/lpfc/lpfc_nvmet.c
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
