From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:22:22 +0200
Subject: [PATCH 6/7] lpfc: Add support for translating an RSCN rcv into a
 discovery rescan
In-Reply-To: <20190513224314.24169-7-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-7-jsmart2021@gmail.com>
Message-ID: <911d2676-c34c-a479-ef23-c2ad08f53e56@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> This patch updates RSCN receive processing to check for the remote
> port being an NVME port, and if so, invoke the nvme_fc callback to
> rescan the remote port.  The rescan will generate a discovery udev
> event.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_crtn.h |  2 ++
>   drivers/scsi/lpfc/lpfc_els.c  |  5 +++++
>   drivers/scsi/lpfc/lpfc_nvme.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 51 insertions(+)
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
