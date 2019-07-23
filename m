From: james.smart@broadcom.com (James Smart)
Date: Tue, 23 Jul 2019 08:59:47 -0700
Subject: [PATCH v2 1/3] nvme: have nvme_init_identify set ctrl->cap
In-Reply-To: <20190723000654.6448-2-sagi@grimberg.me>
References: <20190723000654.6448-1-sagi@grimberg.me>
 <20190723000654.6448-2-sagi@grimberg.me>
Message-ID: <0b926f73-c439-7057-dcb8-75e89486f084@broadcom.com>



On 7/22/2019 5:06 PM, Sagi Grimberg wrote:
> No need to use a stack cap variable.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76cd3dd8736a..058e06e40df8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2563,7 +2563,6 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
>   int nvme_init_identify(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_id_ctrl *id;
> -	u64 cap;
>   	int ret, page_shift;
>   	u32 max_hw_sectors;
>   	bool prev_apst_enabled;
> @@ -2574,15 +2573,15 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   		return ret;
>   	}
>   
> -	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
> +	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
>   	if (ret) {
>   		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
>   		return ret;
>   	}

wondering why we're re-reading CAP if it was already done in 
nvme_enable_ctrl()


-- james
