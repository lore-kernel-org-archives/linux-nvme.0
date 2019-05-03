From: hare@suse.de (Hannes Reinecke)
Date: Fri, 3 May 2019 13:04:48 +0200
Subject: [PATCH 1/2] nvme-multipath: avoid crash on invalid subsystem
 cntlid enumeration
In-Reply-To: <20190403224158.58106-2-hare@suse.de>
References: <20190403224158.58106-1-hare@suse.de>
 <20190403224158.58106-2-hare@suse.de>
Message-ID: <6bb989cf-19a2-9f19-caa4-dd77f90aa6e0@suse.de>

On 4/4/19 12:41 AM, Hannes Reinecke wrote:
> A process holding an open reference to a removed disk prevents it
> from completing deletion, so its name continues to exist. A subsequent
> gendisk creation may have the same cntlid which risks collision when
> using that for the name. Use the unique ctrl->instance instead.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/multipath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f0716f6ce41f..2551264ef2b5 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -31,7 +31,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
>   	} else if (ns->head->disk) {
>   		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> -				ctrl->cntlid, ns->head->instance);
> +				ctrl->instance, ns->head->instance);
>   		*flags = GENHD_FL_HIDDEN;
>   	} else {
>   		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
> 
Ping?

What's the status of this patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
