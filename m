From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Apr 2018 07:39:56 +0200
Subject: [PATCH] nvme: Use admin command effects for admin commands
In-Reply-To: <20180411204812.19131-1-keith.busch@intel.com>
References: <20180411204812.19131-1-keith.busch@intel.com>
Message-ID: <20180412053956.GA30003@lst.de>

On Wed, Apr 11, 2018@02:48:12PM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> This was correct in the first few versions of this patch, and goofed up
> on the last one somehow. Didn't notice until I tested a drive with the
> capability today.
> 
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good!

Btw, time to send another nvme update to Jens?

>
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b70f02bafac6..6ed91ae7f740 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1102,7 +1102,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	}
>  
>  	if (ctrl->effects)
> -		effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
> +		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
>  	else
>  		effects = nvme_known_admin_effects(opcode);
>  
> -- 
> 2.14.3
---end quoted text---
