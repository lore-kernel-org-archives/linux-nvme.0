From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:22:59 +0200
Subject: [PATCH 7/7] lpfc: Add sysfs interface to post NVME RSCN
In-Reply-To: <20190513224314.24169-8-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-8-jsmart2021@gmail.com>
Message-ID: <aee5b973-fd34-62ac-5f07-de0653229d5f@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> To support scenarios which aren't bound to nvmetcli add port scenarios,
> which is currently where the nvmet_fc transport invokes the discovery
> event callbacks, a syfs attribute is added to lpfc which can be written
> to cause an RSCN to be generated for the nport.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc.h      |  1 +
>   drivers/scsi/lpfc/lpfc_attr.c | 60 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
