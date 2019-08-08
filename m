From: kbusch@kernel.org (Keith Busch)
Date: Thu, 8 Aug 2019 15:18:39 -0600
Subject: [PATCH v3 3/7] nvme: make nvme_identify_ns propagate errors back
In-Reply-To: <20190808205325.24036-4-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-4-sagi@grimberg.me>
Message-ID: <20190808211839.GA27519@localhost.localdomain>

On Thu, Aug 08, 2019@01:53:21PM -0700, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that it failed,
> but don't know why. Make nvme_identify_ns propagate the error back.
> 
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f435c85c4062..e503fd14de81 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1108,13 +1108,13 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
>  
>  	id = kmalloc(sizeof(*id), GFP_KERNEL);
>  	if (!id)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
>  	if (error) {
>  		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
>  		kfree(id);
> -		return NULL;
> +		return ERR_PTR(error);

The previous patch has nvme_submit_sync_cmd() return a BLK_STS_* value in
some cases, but ERR_PTR requires -errno's in order for IS_ERR to detect
errors. I think you need:

		if (error > 0)
			return ERR_PTR(blk_status_to_errno(error));
		else
			return ERR_PTR(error);
