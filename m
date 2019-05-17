From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 17 May 2019 17:32:35 +0000
Subject: [PATCH] nvme: Fix known effects
References: <20190517161346.25102-1-keith.busch@intel.com>
Message-ID: <SN6PR04MB4527DDE02A29308B60249AF1860B0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/17/19 9:19 AM, Keith Busch wrote:
> We're trying to append known effects to the ones reported in the
> controller's log. The original patch accomplished this, but something
> went wrong when patch was merged causing the effects log to override
> the known effects.
>
> Link: http://lists.infradead.org/pipermail/linux-nvme/2019-May/023710.html
> Cc: Maxim Levitsky <mlevitsk at redhat.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f2411d50e764..5175451916d1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1273,9 +1273,9 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return 0;
>  	}
>  
> -	effects |= nvme_known_admin_effects(opcode);
>  	if (ctrl->effects)
>  		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> +	effects |= nvme_known_admin_effects(opcode);
>  
>  	/*
>  	 * For simplicity, IO to all namespaces is quiesced even if the command
