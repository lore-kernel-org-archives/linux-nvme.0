From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 09:06:49 +0100
Subject: [PATCH 15/17] lpfc: NVME Target: Add debugfs support
In-Reply-To: <587ec2fa.4XfVnWpJuiX/2Gal%jsmart2021@gmail.com>
References: <587ec2fa.4XfVnWpJuiX/2Gal%jsmart2021@gmail.com>
Message-ID: <4a226c80-fb83-0559-c6c3-031ad78403e2@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Target: Add debugfs support
> 
> Adds debugfs snippets to cover the new NVME target functionality
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_debugfs.c | 387 ++++++++++++++++++++++++++++++++++++++-
>  drivers/scsi/lpfc/lpfc_nvmet.c   | 279 +++++++++++++++++++++++++++-
>  drivers/scsi/lpfc/lpfc_nvmet.h   |  13 ++
>  3 files changed, 674 insertions(+), 5 deletions(-)
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
