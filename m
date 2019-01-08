From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 Jan 2019 08:39:59 -0700
Subject: [PATCH] nvme-core: don't initlialize ctrl->cntlid twice
In-Reply-To: <20190108030849.12870-1-andrew.smirnov@gmail.com>
References: <20190108030849.12870-1-andrew.smirnov@gmail.com>
Message-ID: <20190108153959.GA18014@localhost.localdomain>

On Mon, Jan 07, 2019@07:08:49PM -0800, Andrey Smirnov wrote:
> ctrl->cntlid will already be initialized from id->cntlid for
> non-NVME_F_FABRICS controllers few lines below. For NVME_F_FABRICS
> controllers this field should already be initialized, otherwise the
> check
> 
> 	if (ctrl->cntlid != le16_to_cpu(id->cntlid))
> 
> below will always be a no-op.

Yeah, this bug defeats the fabrics sanity check. Good catch.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2e65be8b1387..1ec87b30fad1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2397,7 +2397,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	ctrl->oaes = le32_to_cpu(id->oaes);
>  	atomic_set(&ctrl->abort_limit, id->acl + 1);
>  	ctrl->vwc = id->vwc;
> -	ctrl->cntlid = le16_to_cpup(&id->cntlid);
>  	if (id->mdts)
>  		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
>  	else
> -- 
