From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 16 May 2019 22:57:08 +0000
Subject: [PATCH 4/4] nvme: release namespace SRCU protection before
 performing controller ioctls
References: <20190516185036.17394-1-hch@lst.de>
 <20190516185036.17394-4-hch@lst.de>
Message-ID: <DM6PR04MB45215AEC51E8B3012AC6CC76860A0@DM6PR04MB4521.namprd04.prod.outlook.com>

Looks good, with couple of small nits.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/16/19 11:51 AM, Christoph Hellwig wrote:
> Holding the SRCU critical section protecting the namespace list can
> cause deadlocks when using the per-namespace admin passthrough ioctl to
> delete as namespace.  Release it earlier when performing per-controller
> ioctls to avoid that.
>
> Reported-by: Kenneth Heitke <kenneth.heitke at intel.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 27f4e0c4be69..a3102aabd525 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1394,14 +1394,31 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	if (unlikely(!ns))
>  		return -EWOULDBLOCK;
>  
> +	/*
> +	 * Handle ioctls that apply to the controller instead of the namespace
> +	 * seperately and drop the ns SRCU reference early.  This avoids a
> +	 * deadlock when deleting namespaces using the passthrough interface.
> +	 */
> +	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd)) {
> +		struct nvme_ctrl *ctrl = ns->ctrl;
> +
> +		nvme_get_ctrl(ns->ctrl);

nit:- just use ctrl instead of ns->ctrl in the above call since we are
already initializing it.

> +		nvme_put_ns_from_disk(head, srcu_idx);
> +
> +		if (cmd == NVME_IOCTL_ADMIN_CMD)
> +			ret = nvme_user_cmd(ctrl, NULL, argp);
> +		else
> +			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
> +
> +		nvme_get_ctrl(ctrl);
As Keith pointed out nvme_put_ctrl().
> +		return ret;
> +	}
> +
>  	switch (cmd) {
>  	case NVME_IOCTL_ID:
>  		force_successful_syscall_return();
>  		ret = ns->head->ns_id;
>  		break;
> -	case NVME_IOCTL_ADMIN_CMD:
> -		ret = nvme_user_cmd(ns->ctrl, NULL, argp);
> -		break;
>  	case NVME_IOCTL_IO_CMD:
>  		ret = nvme_user_cmd(ns->ctrl, ns, argp);
>  		break;
> @@ -1411,8 +1428,6 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	default:
>  		if (ns->ndev)
>  			ret = nvme_nvm_ioctl(ns, cmd, arg);
> -		else if (is_sed_ioctl(cmd))
> -			ret = sed_ioctl(ns->ctrl->opal_dev, cmd, argp);
>  		else
>  			ret = -ENOTTY;
>  	}
