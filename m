From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:20:31 +0200
Subject: [PATCH 5/7] lpfc: add nvmet discovery_event op support
In-Reply-To: <20190513224314.24169-6-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-6-jsmart2021@gmail.com>
Message-ID: <640482f3-059a-ab06-fe71-8d0fe4db1ba5@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> This patch adds support for the nvmet discovery op. When the callback
> routine is called, the driver will call the routine to generate an RSCN
> to the port on the other end of the link.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvmet.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
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
