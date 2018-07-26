From: hare@suse.de (Hannes Reinecke)
Date: Thu, 26 Jul 2018 12:58:19 +0200
Subject: [PATCH] nvme: Register for ANA AEN
In-Reply-To: <20180726105554.80437-1-hare@suse.de>
References: <20180726105554.80437-1-hare@suse.de>
Message-ID: <9a5908f1-92fe-e338-47e0-ad51837b3212@suse.de>

On 07/26/2018 12:55 PM, Hannes Reinecke wrote:
> We need to register for ANA AENs as we rely on them for our ANA implementation.
> Patch is relative to hch nvme-ana tree.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3b96ace1f86d..99910497acdc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1042,6 +1042,10 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>  	u32 supported = ctrl->oaes & NVME_AEN_SUPPORTED, result;
>  	int status;
>  
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->subsys->cmic & (1 << 3))
> +		supported |= NVME_AEN_CFG_ANA_CHANGE;
> +#endif
>  	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported, NULL,
>  			0, &result);
>  	if (status)
> 
Christoph,

this patch fixes the hang I've seen when running my ANA blktest.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
