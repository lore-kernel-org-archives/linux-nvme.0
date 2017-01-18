From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 08:51:43 +0100
Subject: [PATCH 10/17] lpfc: NVME Initiator: Add debugfs support
In-Reply-To: <587ec2f5.kNRcfOkEsCi6Fjot%jsmart2021@gmail.com>
References: <587ec2f5.kNRcfOkEsCi6Fjot%jsmart2021@gmail.com>
Message-ID: <9b0fc106-e073-bc9f-bbbc-93cfc4510c0f@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Initiator: Add debugfs support
> 
> Adds debugfs snippets to cover the new NVME initiator functionality
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h         |  48 +++
>  drivers/scsi/lpfc/lpfc_ct.c      |  27 +-
>  drivers/scsi/lpfc/lpfc_debugfs.c | 775 ++++++++++++++++++++++++++++++++++++++-
>  drivers/scsi/lpfc/lpfc_debugfs.h | 150 +++++++-
>  drivers/scsi/lpfc/lpfc_nvme.c    | 125 +++++++
>  drivers/scsi/lpfc/lpfc_nvme.h    |   7 +
>  drivers/scsi/lpfc/lpfc_sli.c     |   5 +
>  7 files changed, 1128 insertions(+), 9 deletions(-)
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
