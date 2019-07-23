From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 22:43:22 +0900
Subject: [PATCH v2 1/3] nvme: have nvme_init_identify set ctrl->cap
In-Reply-To: <20190723000654.6448-2-sagi@grimberg.me>
References: <20190723000654.6448-1-sagi@grimberg.me>
 <20190723000654.6448-2-sagi@grimberg.me>
Message-ID: <20190723134322.GD7148@minwoo-desktop>

On 19-07-22 17:06:52, Sagi Grimberg wrote:
> No need to use a stack cap variable.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76cd3dd8736a..058e06e40df8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2563,7 +2563,6 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
>  int nvme_init_identify(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_id_ctrl *id;
> -	u64 cap;
>  	int ret, page_shift;
>  	u32 max_hw_sectors;
>  	bool prev_apst_enabled;
> @@ -2574,15 +2573,15 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return ret;
>  	}
>  
> -	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
> +	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);

I think the host drivers already have the CAP values before the
nvme_init_identify() being called.  But it looks good to me with the
goal of this commit.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
