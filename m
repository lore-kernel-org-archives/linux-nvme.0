From: hare@suse.de (Hannes Reinecke)
Date: Fri, 20 Apr 2018 07:43:01 +0200
Subject: [PATCH] nvme: fc: provide a descriptive error
In-Reply-To: <20180419174342.27307-1-jthumshirn@suse.de>
References: <20180419174342.27307-1-jthumshirn@suse.de>
Message-ID: <500112aa-ea97-2428-ac39-854329a52e93@suse.de>

On 04/19/2018 07:43 PM, Johannes Thumshirn wrote:
> Provide a descriptive error in case an lport to rport association
> isn't found when creating the FC-NVME controller.
> 
> Currently it's very hard to debug the reason for a failed connect
> attempt without a look at the source.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> ---
> This actually happened to Hannes and me because of a typo in a
> customer demo today, so yes things like this happen until we have a
> proper way to do auto-connect.
> ---
>  drivers/nvme/host/fc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6cb26bcf6ec0..8b66879b4ebf 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3284,6 +3284,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
>  	}
>  	spin_unlock_irqrestore(&nvme_fc_lock, flags);
>  
> +	pr_warn("%s: %s - %s combination not found\n",
> +		__func__, opts->traddr, opts->host_traddr);
>  	return ERR_PTR(-ENOENT);
>  }
>  
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
